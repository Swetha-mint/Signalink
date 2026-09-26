import pandas as pd
import numpy as np

# =====================================================================
# Project: SIGNALINK (Sense. Process. Communicate. Assist.)
# Component: Sensory Processing Tier (Data Pipeline Simulation)
# Description: Cleans, structures, and filters high-latency or noisy 
#              spatial/sensory stream data for Edge AI consumption.
# =====================================================================

def simulate_sensor_stream(timesteps=100):
    """Simulates multi-dimensional spatial sensor data (e.g., hand gestures)."""
    np.random.seed(42)
    
    # Generate timestamp and synthetic X, Y, Z coordinate metrics with noise
    data = {
        'timestamp': pd.date_range(start='2026-09-26 09:00:00', periods=timesteps, freq='10ms'),
        'sensor_x': np.sin(np.linspace(0, 10, timesteps)) + np.random.normal(0, 0.1, timesteps),
        'sensor_y': np.cos(np.linspace(0, 10, timesteps)) + np.random.normal(0, 0.1, timesteps),
        'sensor_z': np.linspace(0, 5, timesteps) + np.random.normal(0, 0.05, timesteps)
    }
    
    df = pd.DataFrame(data)
    # Simulate a sudden drop/null value common in low-cost hardware interfaces
    df.loc[15, 'sensor_x'] = np.nan
    return df

def clean_and_process_stream(df):
    """Handles missing values and calculates velocity vectors via linear algebra principles."""
    # Step 1: Forward-fill any temporary missing packets (Edge responsiveness)
    df['sensor_x'] = df['sensor_x'].ffill()
    
    # Step 2: Compute spatial magnitude vector (Euclidean distance from origin)
    # Using matrix math concepts: magnitude = sqrt(x^2 + y^2 + z^2)
    df['spatial_magnitude'] = np.sqrt(df['sensor_x']**2 + df['sensor_y']**2 + df['sensor_z']**2)
    
    # Step 3: Apply a basic rolling average filter to smooth high-frequency jitter
    df['smoothed_magnitude'] = df['spatial_magnitude'].rolling(window=5, min_periods=1).mean()
    
    return df

if __name__ == "__main__":
    print("⚡ SIGNALINK Sensory Processing Core Initialized ⚡\n")
    
    # Run the processing pipeline
    raw_stream = simulate_sensor_stream()
    processed_stream = clean_and_process_stream(raw_stream)
    
    # Inspect the final structured payload ready for local inference
    print(processed_stream[['timestamp', 'sensor_x', 'spatial_magnitude', 'smoothed_magnitude']].head(10))
    print("\n✅ Stream clean, filtered, and optimized for Edge AI inference.")
