#!/bin/bash
set -e

INPUT_FILE="$INPUT_INPUT_FILE"
OUTPUT_FILE="$INPUT_OUTPUT_FILE"
THUMBNAIL_FILE="$INPUT_THUMBNAIL_FILE"
EXPORT_SELECTED="$INPUT_EXPORT_SELECTED"

# STL Export
if [[ -n "$OUTPUT_FILE" ]]; then
  echo "Exporting STL to $OUTPUT_FILE"
  mkdir -p "$(dirname "$GITHUB_WORKSPACE/$OUTPUT_FILE")"

  if [[ "$EXPORT_SELECTED" == "true" ]]; then
    echo "→ Exporting only selected objects"
    blender -b "$GITHUB_WORKSPACE/$INPUT_FILE" \
      --python-exit-code 1 \
      --python-expr "import bpy; bpy.ops.wm.stl_export(filepath='$GITHUB_WORKSPACE/$OUTPUT_FILE', export_selected_objects=True)"
  else
    echo "→ Exporting all objects"
    blender -b "$GITHUB_WORKSPACE/$INPUT_FILE" \
      --python-exit-code 1 \
      --python-expr "import bpy; bpy.ops.wm.stl_export(filepath='$GITHUB_WORKSPACE/$OUTPUT_FILE', export_selected_objects=False)"
  fi
fi

# Generate preview via stl-thumb
if [[ -n "$THUMBNAIL_FILE" ]]; then
  echo "Generating STL preview with stl-thumb → $THUMBNAIL_FILE"
  mkdir -p "$(dirname "$GITHUB_WORKSPACE/$THUMBNAIL_FILE")"

  # Ensure stl-thumb is available
  if ! command -v stl-thumb &> /dev/null; then
    echo "Installing stl-thumb v0.5.0 via .deb"
    DEB_URL="https://github.com/unlimitedbacon/stl-thumb/releases/download/v0.5.0/stl-thumb_0.5.0_amd64.deb"
    DEB_FILE="/tmp/stl-thumb_0.5.0_amd64.deb"
    curl -L -o "$DEB_FILE" "$DEB_URL"

    sudo apt-get update
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository universe
    sudo apt-get update

    # Install dependencies
    sudo apt-get install -y libosmesa6-dev libgl1-mesa-dri libglx-mesa0 xvfb

    # Install the .deb package
    sudo dpkg -i "$DEB_FILE" || sudo apt-get -f install -y
  fi

  # Generate preview
  xvfb-run -a stl-thumb "$GITHUB_WORKSPACE/$OUTPUT_FILE" "$GITHUB_WORKSPACE/$THUMBNAIL_FILE" --size 800
fi
