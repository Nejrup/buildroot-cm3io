#!/usr/bin/env bash
set -e

gzip -fk "${BINARIES_DIR}/Image"
cp board/radxa/cm3io/cm3io.its "${BINARIES_DIR}"
(cd "${BINARIES_DIR}" && mkimage -f cm3io.its image.itb)
support/scripts/genimage.sh -c board/radxa/cm3io/genimage.cfg
