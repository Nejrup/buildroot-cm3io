#!/usr/bin/env bash
BOARD_DIR="$(dirname $0)"
set -e

gzip -fk "${BINARIES_DIR}/Image"
cp $BOARD_DIR/cm3io.its "${BINARIES_DIR}"
(cd "${BINARIES_DIR}" && mkimage -f cm3io.its image.itb)
support/scripts/genimage.sh -c $BOARD_DIR/genimage.cfg
