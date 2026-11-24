#!/usr/bin/env bash

set -e

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 input.csv output.csv [project_type]"
    exit 1
fi

INPUT="$1"
OUTPUT="$2"
PROJECT_TYPE="${3:-}"

python3 - "$INPUT" "$OUTPUT" "$PROJECT_TYPE" <<'PYTHON'
import csv
import sys

input_file = sys.argv[1]
output_file = sys.argv[2]
project_type = sys.argv[3]

# Columns to keep
keep_columns = [
    "Number",
    "Title",
    "Project.manager",
    "State",
    "Opening.date",
    "Closing.date",
    "Ending.date",
    "Substate",
]

def is_zero(val):
    if val is None or val.strip() == "":
        return True
    try:
        return float(val) == 0.0
    except ValueError:
        return False

with open(input_file, "r", newline="", encoding="utf-8-sig") as infile:

    reader = csv.DictReader(infile)

    # Identify the month column
    month_column = reader.fieldnames[2]

    # Identify columns starting with Pukki or Rahti
    resource_columns = [
        col for col in reader.fieldnames
        if col.startswith("Pukki") or col.startswith("Rahti")
    ]

    # Build output column list
    output_columns = (
        ["Date"]
        + keep_columns
        + resource_columns
    )

    if project_type:
        output_columns.append("Project type")

    with open(output_file, "w", newline="", encoding="utf-8") as outfile:

        writer = csv.DictWriter(
            outfile,
            fieldnames=output_columns
        )

        writer.writeheader()

        for row in reader:

            # Discard row if all Pukki and Rahti columns are zero
            if all(is_zero(row[col]) for col in resource_columns):
                continue

            # Combine month and year into an ISO date
            month = int(row[month_column])
            year = int(row["Year"])

            date = f"{year:04d}-{month:02d}-01"

            output_row = {
                "Date": date
            }

            # Copy selected columns
            for col in keep_columns + resource_columns:
                output_row[col] = row[col]

            # Optional project type
            if project_type:
                output_row["Project type"] = project_type

            writer.writerow(output_row)

print(f"Created {output_file}")

PYTHON

