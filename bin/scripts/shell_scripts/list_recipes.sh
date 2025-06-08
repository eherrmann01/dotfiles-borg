#!/bin/sh

# Set recipe path
RECIPE_DIR=$HOME/Documents/recipes/one_note_recipes/markdown

# Find and list the .md files
find "$RECIPE_DIR" -type f -name "*.md"
