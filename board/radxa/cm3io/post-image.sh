#!/usr/bin/env bash
set -eo pipefail

BOARD_DIR="$(dirname "$0")"

KERNEL_DIR=$(find "$BUILD_DIR" -maxdepth 1 -type d -name 'linux-6.*' || { echo "Linux kernel directory not found."; exit 1; })

# Copy extlinux
install -m 0644 -D $BOARD_DIR/extlinux.conf $BINARIES_DIR/extlinux/extlinux.conf

# Create the destination folder if it doesn't exist
mkdir -p "$BINARIES_DIR/overlays"

# Iterate through each overlay and preprocess before compiling to DTBO
for overlay in "$BOARD_DIR"/overlays/*.dts; do
    if [ -f "$overlay" ]; then
        # Extract filename without extension
        filename=$(basename -- "$overlay")
        filename_noext="${filename%.*}"

        # Preprocess using cpp, then compile DTO to DTBO
        cpp -nostdinc -I "$KERNEL_DIR/include" -undef -x assembler-with-cpp "$overlay" > "$BINARIES_DIR/overlays/${filename_noext}.tmp" &&
        dtc -@ -H epapr -I dts -O dtb -b 0 -o "$BINARIES_DIR/overlays/${filename_noext}.dtbo" "$BINARIES_DIR/overlays/${filename_noext}.tmp" &&
        echo "Compiled: ${filename_noext}.dtbo" ||
        { echo "Failed to compile: ${filename_noext}.dtbo"; exit 1; }

        # Remove the temporary preprocessed file
        rm "$BINARIES_DIR/overlays/${filename_noext}.tmp"
    fi
done

support/scripts/genimage.sh -c "$BOARD_DIR/genimage.cfg"
