#!/usr/bin/env python3

import requests
import sys
import os

# --- CONFIGURATION ---
API_KEY = 'BCED-79CB-5725-1A3C'
ADIF_FILE = os.path.expanduser('~/logbook.adi')  # Update if needed
QRZ_UPLOAD_URL = 'https://logbook.qrz.com/api'

# --- Upload ADIF ---
def upload_adif():
    if not os.path.isfile(ADIF_FILE):
        print(f"Error: ADIF file '{ADIF_FILE}' not found.")
        sys.exit(1)

    print(f"Uploading {ADIF_FILE} to QRZ.com...")

    with open(ADIF_FILE, 'rb') as f:
        files = {'ADIF': f}
        data = {'KEY': API_KEY, 'ACTION': 'UPLOAD'}

        response = requests.post(QRZ_UPLOAD_URL, data=data, files=files)
        if response.status_code == 200:
            print("✅ Upload successful.")
            print(response.text)
        else:
            print("❌ Upload failed.")
            print(f"HTTP {response.status_code}: {response.text}")

if __name__ == '__main__':
    upload_adif()
