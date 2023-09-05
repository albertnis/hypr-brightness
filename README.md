# Hypr Brightness

Change the brightness on whichever monitor you're currently using. Simple!

Requires the excellent [Hyprland compositor](https://github.com/hyprwm/Hyprland).

## Dependencies

* Hyprland and `hyprctl`
* `jq`
* `brillo` (for laptops; easily replaced with `brightnessctl` or your brightness CLI of choice)
* `ddcutil` (for external monitors)

## Description

hypr_brightness gets monitor information using `hyprctl` which is included with Hyprland. `jq` is used to parse monitor information to extract information about the focused one.

If the focused monitor is `eDP-1` (ie a laptop monitor), `brillo` is used to alter the brightness. Otherwise `ddcutil` sends a command to the focused external monitor.

## Usage

Turn the brightness up on the focused monitor:

```shell
./hypr_brightness.sh +
```

Turn the brightness down on the focused monitor:

```shell
./hypr_brightness.sh +
```

## Bind it to hotkeys

In `hyprland.conf`, add the following lines with the correct path. `binde` will ensure the command repeats as long as the key is held down.

```conf
binde = , XF86MonBrightnessDown, exec, /path/to/hypr_brightness.sh -
binde = , XF86MonBrightnessUp, exec, /path/to/hypr_brightness.sh +
```