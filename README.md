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

## XMobar

```bash
# cabal list xmobar
cabal install xmobar-0.48.1 --allow-newer # Risky
```
