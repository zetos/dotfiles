# README

TODO:

/etc/X11/xorg.conf.d/30-touchpad.conf

addd gnome keyrings for vscode

## XMonad

Setting up xmonad with ghcup + cabal:

after the ghc is in the correct version and cabal binaries are set into the path install xmonad packages.

```bash
cabal install xmonad
cabal install --lib xmonad xmonad-contrib
cabal install xmobar
```

or

```sh
$ cabal update
$ cabal install --package-env=$HOME/.config/xmonad --lib base xmonad xmonad-contrib
$ cabal install --package-env=$HOME/.config/xmonad xmonad
```

make the .xmonad dir into a cabal project.

```
cabal install --dependencies-only
cabal install --overwrite-policy=always
```

setup `.cabal` file inside the `.xmonad` folder & try to `xmonad --recompile`
if theres a missing pkg add it by running:

```bash
cabal install --lib X11
cabal install --lib containers
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
xmonad --recompile
xmonad --restart
```

## XMobar

```bash
# cabal list xmobar
cabal install xmobar-0.48.1 --allow-newer # Risky
```
