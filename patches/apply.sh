#!/bin/sh
# Apply the karen TWRP base patches to the build tree.
# Run from the AOSP/twrp build root BEFORE building:
#   device/oneplus/karen/patches/apply.sh
set -e
ROOT=$(pwd)
if [ ! -f "$ROOT/bootable/recovery/minuitwrp/graphics_drm.cpp" ]; then
    echo "ERROR: run from the build root (the directory containing bootable/)" >&2
    exit 1
fi
if grep -q "DEFAULT_NUM_LMS 1" "$ROOT/bootable/recovery/minuitwrp/graphics_drm.cpp"; then
    echo "patch already applied"
    exit 0
fi
git -C "$ROOT/bootable/recovery" apply --check "$ROOT/device/oneplus/karen/patches/0001-minuitwrp-single-lm.patch" \
  || git -C "$ROOT" apply --check "$ROOT/device/oneplus/karen/patches/0001-minuitwrp-single-lm.patch"
git -C "$ROOT/bootable/recovery" apply "$ROOT/device/oneplus/karen/patches/0001-minuitwrp-single-lm.patch" 2>/dev/null \
  || git -C "$ROOT" apply "$ROOT/device/oneplus/karen/patches/0001-minuitwrp-single-lm.patch"
echo "applied: minuitwrp DEFAULT_NUM_LMS 2 -> 1 (single layer mixer for karen)"
