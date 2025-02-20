## Core packages

Batocera's essential packages. These include the makefiles to compile the packages at build time, configuration of the packages themselves and the script files put into `/etc/init.d` which starts these services.

## Directory navigation

 - `batocera-audio` All of the audio handling. This is where Pipewire is configured.
 - `batocera-configgen` The master folder that contains the config generators and their build configs.
 - `batocera-controller-overlays` The "system controller" tattoos.
 - `batocera-desktopapps` The "Applications" found when pressing F1 in the system list. These allow the user to manually configure standalone emulators or use certain utility applications.
 - `batocera-drm` For devices that use `drm` instead of `xrandr` to resize the screen, this package required.
 - `batocera-image` For the image/screenshot viewer.
 - `reglinux-notice` PDF to use as the user manual (moved to packages/reglinux/).
 - `batocera-scripts` A lot of scripts that are just scripts, not packages, located in `/usr/bin` in the final image.
 - `system-settings` The [system-settings](https://wiki.batocera.org/usage_of_batocera-settings) utility.
 - `batocera-system` Some essential utilities, Batocera version number, profile.d variables, the template `system.conf` and `system-boot.conf` in the final image and per-machine default system.conf key values.
 - `batocera-triggerhappy` Adding functionality to function keys (such as on various supported handhelds, or keyboard volume keys).
