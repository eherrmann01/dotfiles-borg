#   _____      _ _      _____     _    _                                               _____
# |  ____|    (_) |    |  __ \   | |  | |                                             / ____|
# | |__   _ __ _| | __ | |  | |  | |__| | ___ _ __ _ __ _ __ ___   __ _ _ __  _ __   | (___  _ __
# |  __| | '__| | |/ / | |  | |  |  __  |/ _ \ '__| '__| '_ ` _ \ / _` | '_ \| '_ \   \___ \| '__|
# | |____| |  | |   <  | |__| |  | |  | |  __/ |  | |  | | | | | | (_| | | | | | | |  ____) | |_
# |______|_|  |_|_|\_\ |_____(_) |_|  |_|\___|_|  |_|  |_| |_| |_|\__,_|_| |_|_| |_| |_____/|_(_)
#
# Python script to calculate cost in price files for Commander.
# ~/bin/scripts/python_scripts/adjust_costs.py, updated 10/10/2025

import pandas as pd
import sys
import os

# --- Command-line usage ---
# python adjust_costs.py input.xlsx output.xlsx brand_name

# Check that input, output, and brand are provided
if len(sys.argv) != 4:
    print("Usage: python adjust_costs.py <input.xlsx> <output.xlsx> <brand_name>")
    sys.exit(1)

input_file = sys.argv[1]
output_file = sys.argv[2]
brand = sys.argv[3].lower()

# --- Discount mapping per brand ---
discount_maps = {
    "echo": {"A": 0.4, "B": 0.35, "C": 0.25, "E": 0.25, "N": 0, "Y": 0.4},
    "toro": {
        "A": 0.4,
        "B": 0.5,
        "E": 0.25,
        "F": 0.25,
        "L": 0.3,
        "H": 0.15,
        "N": 0,
        "O": 0.2,
        "D": 0.1,
        "S3": 0.1,
        "S5": 0.15,
        "Z": 1.0,
    },
    "exmark": {
        "A1": 0.37,
        "A2": 0.36,
        "A3": 0.35,
        "A4": 0.34,
        "A5": 0.33,
        "A6": 0.31,
        "A7": 0.30,
        "A8": 0.27,
        "A9": 0.2,
        "E": 0.25,
        "N": 0,
        "Z": 0,
    },
}

# --- Select the correct discount map based on brand ---
discount_map = discount_maps.get(brand)
if not discount_map:
    print(f"Unknown brand: {brand}")
    sys.exit(1)

# --- Detect input file type and read ---
ext = os.path.splitext(input_file)[1].lower()
if ext == ".xlsx":
    df = pd.read_excel(input_file)
elif ext == ".csv":
    df = pd.read_csv(input_file)
else:
    print(f"Error: Unsupported input file type '{ext}'")
    sys.exit(1)

# --- Check for unknown codes
unknown_codes = set(row for row in df["Code"].unique() if row not in discount_map)
if unknown_codes:
    print(f"Error: Unknown codes for brand '{brand}': {unknown_codes}")
    sys.exit(1)

# --- Round the original List Price column ---
df["List Price"] = df["List Price"].round(2)

# --- Calculate and round the adjusted price ---
df["Cost"] = df.apply(
    lambda row: round(
        row["List Price"] - row["List Price"] * discount_map.get(row["Code"], 0),
        2,
    ),
    axis=1,
)

# --- Save to output file ---
df.to_excel(output_file, index=False)
print(
    f"✅ Processed {len(df)} rows for brand '{brand}' and saved results to {output_file}"
)
