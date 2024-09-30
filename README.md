# kca overlay

My very own Gentoo Portage overlay.

## Adding this overlay

Using `app-eselect/eselect-repository` : 

```
 # eselect-repository add kca git https://github.com/konrad-campowsky/gentoo-portage-overlay.git 
 # emerge --sync
```

## Contents

 - **dev-libs/simdjson**

   [simdjson](https://github.com/simdjson/simdjson) provides a number of implementations for different processor architectures. On x86_64 those are `icelake` (For CPUs supporting AVX512), `haswell` (for AVX2), and `westmere` (for SSE4.2) as well as a `fallback` implementation for CPUs supporting neither of these extended instruction sets. By default simdjson will build all implementations and upon startup select the one that is best suitable for the CPU it is running on. 

   The vanilla Gentoo ebuild comes with a use flag called `all-impls` that is meant to include all implementations when set and only build the most suitable when omitted. However, the way it selects implementations is broken in the sense that when `all-impls` is set it will indeed build all implementations but select `fallback` as default implementation. When `all-impls` is omitted, all implementations will still be built which is the exact opposite of what the use flag advertises (but at least in this case we fall back to autodetection and get an optimized implementation selected at runtime).

   The ebuild from this overlay  addresses the described issue by relying on the `CPU_FLAGS_X86` portage variable to select and build only the implementation best suited to the current CPU architecture when `all-impls` is omitted from the use flags. When `all-impls` is set, we get the default behaviour of building all implementations with autodetection at runtime.
   
 - **net-wireless/wpa_supplicant**

   Carries a patch that makes wpa_supplicant>=2.10 work with the Broadcom BCM4360 WIFI chipset found in old MacBooks. Without it, messages like `CTRL-EVENT-SCAN-FAILED ret=-22 retry=1` will be encountered during network association and scanning. Make sure to set the `broadcom-sta` use flag.

   The patch is stolen with pride from [here](https://forums.gentoo.org/viewtopic-t-1151111-view-previous.html?sid=38cd8dc94693d96f6e56f54fe9231475).

   Note that the driver for this chipset itself (`net-wireless/broadcom-sta`) is umaintained, yet it seems to be working reasonably well at least on kernel version 6.11.

 - **x11-drivers/nvidia-drivers-470**

   This is the latest version of nvidia-drivers that still supports certain legacy GPUs (in my case specifically the GK107M aka GeForce GT 750M series). The ebuild in this repo carries a patch that allows it to build with newer kernel versions (>=6.10).

   The patch is stolen with pride from [here](https://forums.developer.nvidia.com/t/gpl-only-symbols-follow-pte-and-rcu-read-unlock-prevent-470-256-02-to-build-with-kernel-6-10/300052/5).

 - **x11-misc/lightdm**

   This ebuild adds a `gnome-keyring` use flag that when set will make lightdm unlock the gnome keyring upon login.

