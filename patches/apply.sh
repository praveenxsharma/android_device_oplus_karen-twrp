#!/bin/sh
# Apply the karen TWRP base patches to the build tree.
# Run from the AOSP/twrp build root BEFORE building:
#   device/oneplus/karen/patches/apply.sh
set -e
ROOT=$(pwd)
GR="$ROOT/bootable/recovery"
[ -f "$GR/minuitwrp/graphics_drm.cpp" ] || { echo "ERROR: run from the build root (the directory containing bootable/)" >&2; exit 1; }
for p in "$ROOT"/device/oneplus/karen/patches/0*.patch; do
  if git -C "$GR" apply --check "$p" 2>/dev/null; then
    git -C "$GR" apply "$p"
    echo "applied: $(basename "$p")"
  elif git -C "$ROOT" apply --check "$p" 2>/dev/null; then
    git -C "$ROOT" apply "$p"
    echo "applied at root: $(basename "$p")"
  else
    echo "already applied or not applicable: $(basename "$p")"
  fi
done
