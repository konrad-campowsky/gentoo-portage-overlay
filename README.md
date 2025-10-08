# kca overlay

My very own Gentoo Portage overlay.

## Adding this overlay

Using `app-eselect/eselect-repository` : 

```
 # eselect repository add kca git https://github.com/konrad-campowsky/gentoo-portage-overlay.git 
 # emerge --sync
```

## Contents

 - **app-arch/pbzx**

   [pbzx](https://github.com/NiklasRosenstein/pbzx) is a small tool to unpack macOS disk images in pbzx-format.

   The ebuild was taken and slightly adapted from the [luke-jr overlay](https://github.com/gentoo-mirror/luke-jr).

 - **dev-libs/simdjson**

   [simdjson](https://github.com/simdjson/simdjson) provides a number of implementations for different processor architectures. On x86_64 those are `icelake` (For CPUs supporting AVX512), `haswell` (for AVX2), and `westmere` (for SSE4.2) as well as a `fallback` implementation for CPUs supporting neither of these extended instruction sets. By default simdjson will build all implementations and upon startup select the one that is best suitable for the CPU it is running on. 

   The vanilla Gentoo ebuild comes with a use flag called `all-impls` that is meant to include all implementations when set and only build the most suitable when omitted. However, the way it selects implementations is broken in the sense that when `all-impls` is set it will indeed build all implementations but select `fallback` as default implementation. When `all-impls` is omitted, all implementations will still be built which is the exact opposite of what the use flag advertises (but at least in this case we fall back to autodetection and get an optimized implementation selected at runtime).

   The ebuild from this overlay  addresses the described issue by relying on the `CPU_FLAGS_X86` portage variable to select and build only the implementation best suited to the current CPU architecture when `all-impls` is omitted from the use flags. When `all-impls` is set, we get the default behaviour of building all implementations with autodetection at runtime.

 - **gui-wm/gamescope**

   By default gamescope will on certain errors (e.g. `CreateSwapchainKHR: Creating swapchain for non-Gamescope swapchain.`) stop and ask the user whether it should proceed anyway or abort. This version carries a patch that will inhibit this dialog and always proceed. 

 - **media-video/bcwc_pcie**

   Driver (kernel module) for the Apple Facetime HD Camera found in certain older Macbooks (Broadcom 1570 chipset).

   Note that to work this driver requires certain Kernel configuration options to be enabled that are not directly exposed but just implicitly enabled when selecting other drivers (`CONFIG_VIDEOBUF2_V4L2`, `CONFIG_VIDEOBUF2_CORE`, and `CONFIG_VIDEOBUF2_DMA_SG`). One way to easily enable these options is simply to select a driver that uses them, e.g. `Intel ipu3-cio2 driver` (`CONFIG_VIDEO_IPU3_CIO2=m`).

   The ebuild was taken and adapted from [djs overlay](https://github.com/gentoo-mirror/djs_overlay).

 - **media-video/facetimehd-colorprofiles**

   Sensor calibration / color profiles (`1771_01XX.dat`, `1871_01XX.dat`, `1874_01XX.dat`, `9112_01XX.dat`) for Apple Facetime HD cameras.

   Based on some black magic conjured up by Patrik Jakobsson found [here](https://github.com/patjak/facetimehd/wiki/Extracting-the-sensor-calibration-files).  

 - **media-video/facetimehd-firmware**

   Firmware for the Apple Facetime HD Camera found in certain older Macbooks (Broadcom 1570 chipset).

   The ebuild is based on an ebuild from the [menelkir overlay](https://gpo.zugaina.org/Overlays/menelkir).

 - **net-wireless/wpa_supplicant**

   Carries a patch that makes wpa_supplicant>=2.10 work with the Broadcom BCM4360 WIFI chipset found in old MacBooks. Without it, messages like `CTRL-EVENT-SCAN-FAILED ret=-22 retry=1` will be encountered during network association and scanning. Make sure to set the `broadcom-sta` use flag.

   The patch is stolen with pride from [here](https://forums.gentoo.org/viewtopic-t-1151111-view-previous.html?sid=38cd8dc94693d96f6e56f54fe9231475).

   Note that the driver for this chipset itself (`net-wireless/broadcom-sta`) is umaintained, yet it seems to be working reasonably well at least on kernel version 6.12

 - **sys-apps/gpu-switch**

   Utility to switch between IGP and dedicated GPU on certain Macbook Pro models.

   Stolen with pride from [here](https://github.com/0xbb/gpu-switch).

 - **sys-auth/pambase**

   Adapted ebuild in which the `minimal` use flag also removes the `pam_nologin`, `pam_time`, and `pam_access` modules from `/etc/pam.d/system-login`.

 - **sys-kernel/gentoo-sources** 

   This ebuild adds a `apple-hybrid-gpu` use flag that will force the kernel to identify itself as MacOS 10.9 towards the device firmware when running as EFI stub.

   Background: Certain Apple MacBook Pro models with hybrid graphics (Intel Macs with dedicated Nvidia GPU and onboard Intel IGP) will switch off the onboard chipset unless they are made to believe that they are running MacOS. The Linux kernel already includes facilities to provide this spoofed identification when it is running as an efi stub on an affected MacBook model which in turn the kernel identifies by reading some firmware information. So, usually this works out of the box, however some specimens of MacBooks come with broken firmware which the Kernel is not able to read properly. Setting `USE=apple-hybrid-gpu` will force the Kernel to always identify as MacOS.

 - **sys-kernel/it87**

   Hardware monitoring driver for IT8705F/IT871xF/IT872xF sensor chips as for example found on Gigabyte Aorus boards. This driver supports a wider range of chips than the `it87` module in the official Linux kernel tree. Note that this module conflicts with the in-kernel variant so the latter must be disabled.

   Ebuild ist taken and adapted from the [Sunset overlay](https://github.com/Anonymous1157/sunset-repo).

 - **x11-apps/lightdm-gtk-greeter-settings**

   Fixes a "No such file or directory" crash on startup due to a wrong path being set during installation.

 - **x11-drivers/nvidia-drivers-470**

   This is the latest version of nvidia-drivers that still supports certain legacy GPUs (in my case specifically the GK107M aka GeForce GT 750M series). The ebuild in this repo carries a patch that allows it to build with newer kernel versions (tested with 6.12).

   The patches are stolen with pride and adapted from [here](https://forums.developer.nvidia.com/t/gpl-only-symbols-follow-pte-and-rcu-read-unlock-prevent-470-256-02-to-build-with-kernel-6-10/300052/5) and [here](https://github.com/NVIDIA/open-gpu-kernel-modules/issues/708#issuecomment-2377038258).

 - **x11-misc/lightdm**

   This ebuild adds a `gnome-keyring` use flag that when set will make lightdm unlock the gnome keyring upon login.

