#!/system/bin/sh
# PropHide bootloader and verified boot state spoofing

VBMETA_DEV="/dev/block/by-name/vbmeta$(getprop ro.boot.slot_suffix)"

rezetprop -n ro.boot.flash.locked "1"
rezetprop -n ro.boot.vbmeta.avb_version "1.3"
rezetprop -n ro.boot.vbmeta.device_state "locked"
rezetprop -n ro.boot.vbmeta.digest "$(dd if="$VBMETA_DEV" bs=1 count={{vbmeta.size}} 2> /dev/null | sha256sum -b | cut -d' ' -f1)"
rezetprop -n ro.boot.vbmeta.hash_alg "sha256"
rezetprop -n ro.boot.vbmeta.invalidate_on_error "yes"
rezetprop -n ro.boot.vbmeta.public_key_digest "$(dd if="$VBMETA_DEV" bs=1 skip={{vbmeta.publickey.offset}} count={{vbmeta.publickey.size}} 2> /dev/null | sha256sum -b | cut -d' ' -f1)"
rezetprop -n ro.boot.vbmeta.size "{{vbmeta.size}}"
rezetprop -n ro.boot.warranty_bit "0"
rezetprop -n ro.boot.verifiedbootstate "green"
rezetprop -n ro.boot.veritymode "enforcing"
rezetprop -n ro.vendor.boot.warranty_bit "0"
rezetprop -n ro.vendor.build.security_patch "$(getprop ro.build.version.security_patch)"
rezetprop -n sys.oem_unlock_allowed "0"
