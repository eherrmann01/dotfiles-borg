#  ______      _ _      _____     _    _                                               _____
# |  ____|    (_) |    |  __ \   | |  | |                                             / ____|
# | |__   _ __ _| | __ | |  | |  | |__| | ___ _ __ _ __ _ __ ___   __ _ _ __  _ __   | (___  _ __
# |  __| | '__| | |/ / | |  | |  |  __  |/ _ \ '__| '__| '_ ` _ \ / _` | '_ \| '_ \   \___ \| '__|
# | |____| |  | |   <  | |__| |  | |  | |  __/ |  | |  | | | | | | (_| | | | | | | |  ____) | |_
# |______|_|  |_|_|\_\ |_____(_) |_|  |_|\___|_|  |_|  |_| |_| |_|\__,_|_| |_|_| |_| |_____/|_(_)

# Python script to convert PDF tables to .ods spreadsheets - updated 08/05/2025
# ~/bin/scripts/python_scripts/pdf_to_ods.py

from pathlib import Path
import pdfplumber
import pandas as pd

# Set the path to your PDF file
pdf_path = Path("PWP_Parts.pdf")

# Create an empty list to collect tables
all_tables = []

# Open the PDF using pdfplumber
with pdfplumber.open(pdf_path) as pdf:
    for page in pdf.pages:
        table = page.extract_table()
        if table:
            # Create a DataFrame from the table, using the first row as the header
            df = pd.DataFrame(table[1:], columns=table[0])
            all_tables.append(df)

# Combine all individual tables into one big table
if all_tables:
    full_table = pd.concat(all_tables, ignore_index=True)

    # Set the output filename
    output_file = Path("PWP_Parts_Converted.ods")

    # Save the full table to an .ods file (LibreOffice format)
    full_table.to_excel(output_file, engine="odf", index=False)

    print(f"Saved successfully to: {output_file}")
else:
    print("No tables were found in the PDF.")
