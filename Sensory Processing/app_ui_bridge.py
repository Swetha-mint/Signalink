import http.server
import socketserver
import json
import time
import threading
import numpy as np

# Global variable to safely hold the absolute latest system data frame across threads
latest_system_frame = {
    "frame": 0,
    "coord_x": 0.0,
    "coord_y": 0.0,
    "token": "START/REST"
}


def live_gesture_stream_emulator():
    """Background engine simulating continuous human gesture coordinate loops."""
    global latest_system_frame
    frame_counter = 0

    while True:
        t = time.time()
        raw_x = (np.sin(t) * 4) + 4.5 + np.random.normal(0, 0.15)
        raw_y = (np.cos(t) * 4) + 4.5 + np.random.normal(0, 0.15)

        if raw_x < 2.0 and raw_y < 2.0:
            detected_token = "START/REST"
        elif 6.5 <= raw_x <= 9.5 and 1.5 <= raw_y <= 4.5:
            detected_token = "TOKEN_A (Letter A Flexion)"
        elif 0.0 <= raw_x <= 4.0 and 7.0 <= raw_y <= 11.0:
            detected_token = "TOKEN_B (Letter B Extension)"
        else:
            detected_token = "TRANSITIONING..."

        latest_system_frame = {
            "frame": frame_counter,
            "coord_x": round(float(raw_x), 2),
            "coord_y": round(float(raw_y), 2),
            "token": detected_token
        }

        frame_counter += 1
        time.sleep(0.15)


class SignalinkInterfaceHandler(http.server.BaseHTTPRequestHandler):
    """Serve the visual feedback dashboard and live JSON data API."""

    def log_message(self, format, *args):
        return

    def do_GET(self):
        if self.path == '/':
            self.send_response(200)
            self.send_header('Content-type', 'text/html')
            self.end_headers()

            html_ui = """
            <!DOCTYPE html>
            <html>
            <head>
                <title>SIGNALINK | Assistive Dashboard</title>
                <style>
                    body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #0d1117; color: #c9d1d9; margin: 0; padding: 40px; display: flex; flex-direction: column; align-items: center; }
                    .container { max-width: 700px; width: 100%; background: #161b22; border: 1px solid #30363d; border-radius: 12px; padding: 30px; box-shadow: 0 8px 24px rgba(0,0,0,0.5); text-align: center; }
                    h1 { color: #58a6ff; margin-bottom: 5px; font-weight: 600; letter-spacing: 1px; }
                    .tagline { color: #8b949e; font-size: 14px; margin-bottom: 30px; text-transform: uppercase; }
                    .data-box { background: #0d1117; border: 1px solid #21262d; border-radius: 8px; padding: 20px; margin: 15px 0; display: flex; justify-content: space-around; font-family: monospace; font-size: 18px; }
                    .metric { color: #ff7b72; font-weight: bold; }
                    .token-display { font-size: 32px; font-weight: bold; color: #56d364; background: #0d1117; border: 2px solid #238636; border-radius: 8px; padding: 25px; margin-top: 25px; letter-spacing: 1px; text-shadow: 0 0 10px rgba(86,211,100,0.2); }
                    .pulse { width: 12px; height: 12px; background-color: #56d364; border-radius: 50%; display: inline-block; margin-right: 8px; animation: blink 1.5s infinite; }
                    @keyframes blink { 0% { opacity: 0.3; } 50% { opacity: 1; } 100% { opacity: 0.3; } }
                </style>
            </head>
            <body>
                <div class="container">
                    <h1>SIGNALINK INTERFACE</h1>
                    <div class="tagline">Sense. Process. Communicate. Assist.</div>
                    <div style="text-align: left; font-size: 14px; color: #8b949e; margin-bottom: 10px;">
                        <span class="pulse"></span>LIVE FEEDBACK STREAM ACTIVE
                    </div>
                    <div class="data-box">
                        <div>Frame: <span id="lbl-frame" class="metric">-</span></div>
                        <div>Coord X: <span id="lbl-x" class="metric">-</span></div>
                        <div>Coord Y: <span id="lbl-y" class="metric">-</span></div>
                    </div>
                    <div style="margin-top: 30px; text-align: left; font-size: 14px; color: #8b949e;">DETECTED OUTPUT TOKEN:</div>
                    <div id="lbl-token" class="token-display">INITIALIZING...</div>
                </div>
                <script>
                    function fetchLiveSignalPayload() {
                        fetch('/data')
                            .then(response => response.json())
                            .then(payload => {
                                document.getElementById('lbl-frame').innerText = payload.frame;
                                document.getElementById('lbl-x').innerText = payload.coord_x.toFixed(2);
                                document.getElementById('lbl-y').innerText = payload.coord_y.toFixed(2);
                                document.getElementById('lbl-token').innerText = payload.token;
                            })
                            .catch(err => console.error("Stream disconnect error:", err));
                    }
                    setInterval(fetchLiveSignalPayload, 150);
                    fetchLiveSignalPayload();
                </script>
            </body>
            </html>
            """
            self.wfile.write(html_ui.encode("utf-8"))

        elif self.path == '/data':
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            self.wfile.write(json.dumps(latest_system_frame).encode("utf-8"))

        else:
            self.send_response(404)
            self.end_headers()


if __name__ == "__main__":
    PORT = 8080

    print("=====================================================================")
    print("🛰  SIGNALINK USER INTERFACE BRIDGE ENGINE INITIALIZED               ")
    print("=====================================================================")

    emulator_worker = threading.Thread(target=live_gesture_stream_emulator, daemon=True)
    emulator_worker.start()
    print("🚀 Background Spatial Ingestion Emulator started.")

    socketserver.TCPServer.allow_reuse_address = True
    with socketserver.TCPServer(("", PORT), SignalinkInterfaceHandler) as httpd:
        print(f"📡 Visual Feedback Dashboard live at: http://localhost:{PORT}/")
        print("💡 Open this URL in your web browser to view the running system loop.")
        print("⌨️  Press Ctrl+C inside this terminal window to stop the interface.")
        print("=====================================================================")

        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\nShutting down interface infrastructure baseline cleanly.")
