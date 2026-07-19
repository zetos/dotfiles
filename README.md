# Dotfiles

Personal dotfiles for an Arch Linux desktop running X11, XMonad, and Xmobar.
The repository also contains Alacritty, Bash, Xresources, Starship, Stalonetray,
package installation, and machine-specific system configuration.

These files reflect one workstation rather than a portable distribution. Review
network interfaces, keyboard layouts, drivers, monitor settings, and system paths before using them on another machine.

## Requirements

- Arch Linux with `git`, `sudo`, and the `base-devel` package group
- [`yay`](https://github.com/Jguer/yay) for repository and AUR packages
- [GHCup](https://www.haskell.org/ghcup/) for GHC and Cabal

Install GHCup using its upstream instructions. GHC, Cabal, and other Haskell
tools should be managed through GHCup rather than installed with Pacman. The
versions currently verified with this configuration are GHC 9.10.3 and Cabal
3.16.1.0:

```bash
ghcup install ghc 9.10.3
ghcup set ghc 9.10.3
ghcup install cabal 3.16.1.0
ghcup set cabal 3.16.1.0
```

The included `.bashrc` adds `~/.ghcup/bin`, `~/.cabal/bin`, and `~/.local/bin`
to `PATH`. `cabal path --installdir` prints the directory where Cabal installs
executables on the current machine.

## Install Packages

Clone the repository and run the interactive package installer as a regular
user:

```bash
git clone https://github.com/zetos/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles
./scripts/install-packages.sh
```

The script uses `yay` and asks before installing each package or package group;
press Enter to accept an item. The list includes the desktop programs referenced
by the XMonad and X session configurations, including Dmenu, URxvt, Nitrogen,
Picom, Pamixer, Stalonetray, and the Iosevka font.

The NVIDIA prompt installs the legacy 470xx driver used by this workstation. It
is not appropriate for every NVIDIA GPU; skip it unless the hardware requires
that driver branch.

## Link the Dotfiles

The configurations are intended to be symlinked so edits in the repository are
immediately used by the desktop. Back up or move any existing destination first.
The following `ln` commands do not overwrite existing files and will fail safely
if a destination is still present.

From the repository root:

```bash
mkdir -p ~/.config/alacritty/themes ~/.config/xmonad ~/.Xresources.d

ln -s "$PWD/.bashrc" ~/.bashrc
ln -s "$PWD/.xinitrc" ~/.xinitrc
ln -s "$PWD/.Xresources" ~/.Xresources
ln -s "$PWD/.Xresources.d/nord" ~/.Xresources.d/nord
ln -s "$PWD/.Xresources.d/night-owl" ~/.Xresources.d/night-owl
ln -s "$PWD/.config/alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml
ln -s "$PWD/.config/alacritty/themes/nord.toml" ~/.config/alacritty/themes/nord.toml
ln -s "$PWD/.config/alacritty/themes/night-owl.toml" ~/.config/alacritty/themes/night-owl.toml
ln -s "$PWD/.config/starship.toml" ~/.config/starship.toml
ln -s "$PWD/.config/stalonetrayrc" ~/.config/stalonetrayrc
ln -s "$PWD/.config/xmonad/xmonad.hs" ~/.config/xmonad/xmonad.hs
ln -s "$PWD/.config/xmonad/xmobar.hs" ~/.config/xmonad/xmobar.hs
ln -s "$PWD/.config/xmonad/xmobar-night-owl.hs" ~/.config/xmonad/xmobar-night-owl.hs
```

Keep `~/.config/xmonad` itself as a local directory instead of symlinking the
whole directory. Cabal writes compiler-specific `.ghc.environment.*` files
there, and those generated files should remain outside this repository.

System-level files such as `30-touchpad.conf`, `fix-nvidia.sh`, and `limine/`
are intentionally excluded from this linking procedure.

## XMonad and Xmobar

### Install

Install the Xorg and native library dependencies as root:

```bash
sudo bash ./scripts/install-xmonad-dependencies.sh
```

After installing and selecting GHC and Cabal with GHCup, create the package
environment used to compile `~/.config/xmonad/xmonad.hs`:

```bash
cd ~/.config/xmonad
cabal update
cabal install --lib \
  X11-1.10.3 \
  xmonad-0.18.0 \
  xmonad-contrib-0.18.1 \
  containers \
  --package-env .
```

Install the XMonad and Xmobar executables separately:

```bash
cabal install \
  xmonad-0.18.0 \
  xmobar-0.50 \
  --overwrite-policy=always
```

Confirm that the Cabal executable directory is on `PATH`, then compile the
configuration:

```bash
cabal path --installdir
xmonad --recompile
```

### Local settings

Review these workstation-specific values before starting X:

- `.config/xmonad/xmobar.hs` uses network interface `enp4s0`.
- The Xmobar keyboard indicator expects BR and US keyboard layouts.
- XMonad uses URxvt, Dmenu, and GNOME Screenshot.
- `.xinitrc` starts Nitrogen, Picom, NumLockX, and XMonad.
- The XMonad and Xmobar configurations expect the Iosevka fonts installed by
  the package script.

Start the X session with:

```bash
startx
```

### Rebuilding after a GHC upgrade

Cabal package environments are tied to the GHC version that compiled their
packages. For example, packages referenced by
`.ghc.environment.x86_64-linux-9.10.1` cannot be loaded by GHC 9.10.3. Renaming
the old environment file does not make those packages compatible; rebuild them
for the active compiler instead.

From the XMonad configuration directory, create a package environment for the
current GHC version using the versions verified with this configuration:

```bash
cd ~/.config/xmonad
cabal install --lib \
  X11-1.10.3 \
  xmonad-0.18.0 \
  xmonad-contrib-0.18.1 \
  containers \
  --package-env .
```

Run `cabal update` first if Cabal reports that its package list is stale. The
command creates a new `.ghc.environment.x86_64-linux-<version>` file for the
active compiler. This generated, machine-specific file should not be copied to
the dotfiles repository.

Recompile before restarting so the current window manager remains available if
compilation fails:

```bash
xmonad --recompile && xmonad --restart
```

## Themes

Nord is the default for XMonad, Xmobar, Stalonetray, and Xresources; Night Owl
is also available. Alacritty keeps its existing default colors unless one of
those palettes is selected separately. The repository files must be linked to
the matching paths under `$HOME` before running reload commands.

To select a theme:

1. Set `myTheme` in `.config/xmonad/xmonad.hs` to either `nordTheme` or
   `nightOwlTheme`. This also selects the matching Xmobar configuration and
   Stalonetray background.
2. Enable the matching `#include` near the end of `.Xresources` and comment out
   the other include.
3. Start a new X session. This reloads Xresources and replaces the existing
   Stalonetray process. For XMonad-only changes, recompile and restart XMonad.

```bash
xmonad --recompile && xmonad --restart
```

The theme files are:

- Nord Xmobar: `.config/xmonad/xmobar.hs`
- Night Owl Xmobar: `.config/xmonad/xmobar-night-owl.hs`
- Nord Xresources: `.Xresources.d/nord`
- Night Owl Xresources: `.Xresources.d/night-owl`

### Alacritty

Alacritty keeps `window.opacity = 0.3` in its base configuration, so its default
colors, Nord, and Night Owl all use the same transparency. The default colors
remain active while both imports at the top of
`.config/alacritty/alacritty.toml` are commented.

To select Nord or Night Owl, uncomment exactly one of these imports:

```toml
[general]
import = ["~/.config/alacritty/themes/nord.toml"]
```

```toml
[general]
import = ["~/.config/alacritty/themes/night-owl.toml"]
```

Comment the import again to return to Alacritty's default colors. Alacritty
reloads configuration changes automatically.

The Alacritty theme files are:

- Nord: `.config/alacritty/themes/nord.toml`
- Night Owl: `.config/alacritty/themes/night-owl.toml`

## Machine-Specific Setup

Review these files before using them; they modify system configuration or make
hardware-specific assumptions:

- `fix-nvidia.sh` configures the legacy NVIDIA driver and regenerates initramfs.
- `scripts/setup-docker.sh` enables Docker and changes group membership.
- `30-touchpad.conf` belongs under `/etc/X11/xorg.conf.d/` when its touchpad
  settings are appropriate for the machine.
- `limine/limine.conf` contains a fixed partition UUID, filesystem, resolution,
  and wallpaper path.
- VS Code keyring integration is not configured by this repository.
