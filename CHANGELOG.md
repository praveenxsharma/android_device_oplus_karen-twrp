# Changelog

## Unreleased - android-13 (2)

- Fix the half-screen rendering on the OOS13 kernel: TWRP's MTK
  topology parser falls back to 2 layer mixers when it cannot parse
  the kernel's mode_properties blob, splitting the framebuffer into
  half-width planes (complete UI squeezed into a narrow strip).
  patches/0001-minuitwrp-single-lm.patch defaults to a single LM.
  Run device/oneplus/karen/patches/apply.sh from the build root
  before building.

## Unreleased - android-13

- Rebase on the android-13 (TWRP 3.7.x twrp-13) base: the device now runs
  OxygenOS 13 (Android 13) firmware.
- Swap prebuilt kernel, dtb and dtbo to the OOS 13 (TP1A.220905.001,
  2023-03) images, taken byte-identical from a CPH2401 A13 dump
  (kernel 4.19.191).

## [3.7.0_12-1-UNOFFICIAL] - 2022-10-15

- Update the `kernel` and `dtbo.img` to use A.15 version.
- Rebuild with upstream patch, that should fix the `lpdump` utility.

[3.7.0_12-1-UNOFFICIAL]: https://github.com/oneplus-karen-roms/android_device_oneplus_karen-twrp/releases/tag/3.7.0_12-1-UNOFFICIAL


## [3.7.0_12-0-UNOFFICIAL] - 2022-10-09

The unofficial build is ready enough to show XDA and apply for official.

[3.7.0_12-0-UNOFFICIAL]: https://github.com/oneplus-karen-roms/android_device_oneplus_karen-twrp/releases/tag/3.7.0_12-0-UNOFFICIAL
