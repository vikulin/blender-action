#!/bin/bash

# Ensure subfolders exist for the output file
output_dir=$(dirname "$GITHUB_WORKSPACE/$2")
mkdir -p "$output_dir"

INPUT_FILE="$1"
OUTPUT_FILE="$2"

blender -b "$INPUT_FILE" \
  --python-exit-code 1 \
  --python-expr "import bpy; bpy.ops.wm.stl_export(filepath='$OUTPUT_FILE')"

