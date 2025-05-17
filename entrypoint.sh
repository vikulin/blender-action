#!/bin/bash
set -e

INPUT_FILE="$INPUT_INPUT_FILE"
OUTPUT_FILE="$INPUT_OUTPUT_FILE"
RENDER_FILE="$INPUT_RENDER_FILE"

# STL Export
if [[ -n "$OUTPUT_FILE" ]]; then
  echo "Exporting STL to $OUTPUT_FILE"
  mkdir -p "$(dirname "$GITHUB_WORKSPACE/$OUTPUT_FILE")"
  blender -b "$GITHUB_WORKSPACE/$INPUT_FILE" \
    --python-exit-code 1 \
    --python-expr "import bpy; bpy.ops.wm.stl_export(filepath='$GITHUB_WORKSPACE/$OUTPUT_FILE')"
fi

# PNG Render
if [[ -n "$RENDER_FILE" ]]; then
  echo "Rendering PNG to $RENDER_FILE"
  mkdir -p "$(dirname "$GITHUB_WORKSPACE/$RENDER_FILE")"

  # Remove file extension for Blender's -o (e.g. output.png → output)
  RENDER_PATH_NO_EXT="${RENDER_FILE%.*}"

  blender -b "$GITHUB_WORKSPACE/$INPUT_FILE" \
    -o "$GITHUB_WORKSPACE/$RENDER_PATH_NO_EXT" \
    -F PNG -f 1
fi