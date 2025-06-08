#!/bin/sh

# Set recipe path
RECIPE_DIR=$HOME/Documents/recipes/one_note_recipes/markdown

# Find and list the .md files
find "$RECIPE_DIR" -type f -name "*.md" | while read -r md_file; do
# Build output .docx path
  docx_file=${md_file%.md}.docx

  echo "Converting: $md_file -> $docx_file"

# Run Pandoc to convert
  pandoc "$md_file" -o "$docx_file"
done
