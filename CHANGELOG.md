# Changelog

## Unreleased - android-13 (2)

- Fix the half-screen/squeezed strip rendering on the OOS13 kernel:
  - Root cause: TWRP's graphics backend (`minuitwrp`) assumes a Qualcomm-style
    dual-layer-mixer display by default (`DEFAULT_NUM_LMS = 2`). The MTK single-DSI
    1080x2400 panel exposes no `mode_properties` topology blob, so minuitwrp
    split the framebuffer across two 540px-wide planes (`src_w = 540`, `crtc_w = 540`)
    on Plane 30 (Primary) and Plane 42 (Overlay). Only Plane 30 scanned out,
    resulting in the complete UI being rendered squeezed into a ~40-50% width vertical strip.
  - Build trap: Incremental `mka bootimage` builds did not automatically update
    `libminuitwrp.so` in `out/.../recovery/root/system/lib64/`, causing the ramdisk
    to retain the stale 2-LM unpatched binary.
  - Solution: `patches/0001-minuitwrp-single-lm.patch` forces `DEFAULT_NUM_LMS = 1`
    (single full-width 1080x2400 plane on Plane 30).
  - Killed hypotheses:
    * H2 (60Hz vs 90Hz DSC mode mismatch): Both connector modes use identical timing;
      preferred mode #0 (58.52Hz) matches bootloader initialization.
    * H3 (Plane scanout pitch/format): Pitch is standard 4320 (1080x4), format XR24/XB24.
    * H4 (YE01 vs YE05 driver mismatch): Driver diff confirms byte-identical timing and DSC tables.
    * H5 (dsi-channel-num): Benign probe-time warning.
    * Theme scaling: 1.000000x width / 1.190104x height only compensates vertical notch.
  - Power button / Decryption status:
    * Power button: `mtk-kpd` registers KEY_POWER (116), but hardware interrupts in recovery
      remain unresolved.
    * Decryption: FBE metadata encryption decryption fails due to `vendor.oplus.hardware.cryptoeng@1.0-service`
      exiting on boot.


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
