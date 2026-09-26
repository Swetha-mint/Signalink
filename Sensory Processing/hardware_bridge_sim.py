import pandas as pd
import numpy as np

# =====================================================================
# Project: SIGNALINK (Sense. Process. Communicate. Assist.)
# Component: Sensory Processing Tier (Hardware Bridge Simulation)
# Description: Emulates real-world sensor streams, applies noise filters,
#              and quantizes physical metrics into 4-bit words for the
#              Verilog ALU core inputs.
# =====================================================================

def generate_gesture_signal(samples=50):
    """Simulates a continuous physical gesture wave (e.g., a hand flexion sensor)."""
    np.random.seed(42)
    time = np.linspace(0, 4, samples)
    base_signal = np.sin(time) * 5 + 5
    noise = np.random.normal(0, 0.4, samples)
    raw_stream = base_signal + noise
    return pd.DataFrame({'raw_sensor_voltage': raw_stream})


def process_and_quantize(df):
    """Filters jitter and converts signals to a 4-bit hardware range (0-15)."""
    df['filtered_signal'] = df['raw_sensor_voltage'].rolling(window=3, min_periods=1).mean()
    df['clipped_signal'] = df['filtered_signal'].clip(lower=0, upper=10)
    df['4bit_hardware_word'] = np.round((df['clipped_signal'] / 10.0) * 15).astype(int)
    df['verilog_binary_input'] = df['4bit_hardware_word'].apply(lambda x: f"4'b{x:04b}")
    return df


if __name__ == "__main__":
    print("=====================================================================")
    print("SIGNALINK SENSORY INTERFACE: REAL-TIME QUANTIZATION ENGINE")
    print("=====================================================================")
    raw_data = generate_gesture_signal()
    processed_data = process_and_quantize(raw_data)
    print("\nTimeStep | Raw Volt | Filtered | 4-Bit Int | Verilog Wire Input Pattern")
    print("-" * 72)
    for index, row in processed_data.head(12).iterrows():
        print(f"  {index:02d}     |  {row['raw_sensor_voltage']:0.2f}    |   {row['filtered_signal']:0.2f}   |    {int(row['4bit_hardware_word']):02d}     | {row['verilog_binary_input']}")
    print("\nQuantization successful. Data stream is structured for Verilog ALU input buses.")
