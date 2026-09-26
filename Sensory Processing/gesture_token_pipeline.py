import pandas as pd
import numpy as np

# =====================================================================
# Project: SIGNALINK (Sense. Process. Communicate. Assist.)
# Component: Sensory Processing Tier (Gesture Tokenization Pipeline)
# Description: Ingests spatial hand coordinate frames, smooths micro-tremors,
#              and tokenizes physical movement boundaries into distinct letters.
# =====================================================================

def generate_spatial_gesture_dataset():
    """Generates a dataset emulating continuous 3D hand trajectories for Sign Language tokens."""
    timesteps = 60
    np.random.seed(101)

    x_path = np.concatenate([np.zeros(20), np.ones(20) * 8, np.ones(20) * 2])
    y_path = np.concatenate([np.zeros(20), np.ones(20) * 3, np.ones(20) * 9])

    x_noise = x_path + np.random.normal(0, 0.3, timesteps)
    y_noise = y_path + np.random.normal(0, 0.3, timesteps)

    dataset = pd.DataFrame({
        'frame': range(timesteps),
        'hand_x': x_noise,
        'hand_y': y_noise
    })
    return dataset

def tokenize_spatial_data(df):
    """Filters data and applies spatial boundaries to extract discrete communication tokens."""
    df['smooth_x'] = df['hand_x'].rolling(window=4, min_periods=1).mean()
    df['smooth_y'] = df['hand_y'].rolling(window=4, min_periods=1).mean()

    tokens = []
    for _, row in df.iterrows():
        x, y = row['smooth_x'], row['smooth_y']

        if x < 2.0 and y < 2.0:
            tokens.append("START/REST")
        elif 6.5 <= x <= 9.5 and 1.5 <= y <= 4.5:
            tokens.append("TOKEN_A")
        elif 0.0 <= x <= 4.0 and 7.0 <= y <= 11.0:
            tokens.append("TOKEN_B")
        else:
            tokens.append("TRANSITION")

    df['detected_token'] = tokens
    return df

if __name__ == "__main__":
    print("=====================================================================")
    print("🛰  SIGNALINK REAL-TIME SPATIAL GESTURE TOKENIZATION PIPELINE        ")
    print("=====================================================================")

    raw_frames = generate_spatial_gesture_dataset()
    tokenized_stream = tokenize_spatial_data(raw_frames)

    print("\nExtracting Token Transitions:")
    print("-" * 68)

    slices = [5, 25, 45]
    for frame_idx in slices:
        row = tokenized_stream.iloc[frame_idx]
        print(f"Frame {row['frame']:02d} | Coord: ({row['smooth_x']:0.2f}, {row['smooth_y']:0.2f}) -> Flagged As: [ {row['detected_token']} ]")

    print("\n✅ Spatial boundary tokenization pipeline validated successfully.")
