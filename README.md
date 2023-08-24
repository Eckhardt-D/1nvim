# 1nvim

A single bash script to install Neovim and configure with [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

## Installing

```bash
curl -fsSL https://raw.githubusercontent.com/Eckhardt-D/1nvim/main/install.sh | bash
```

## What does this do?

Firstly, Windows is not currently supported, planning to soon. But on Mac it uses `brew` to install Neovim if it isn't installed yet. On Linux it uses `.appimage` to store the binary and links it to `/usr/bin/nvim`.

Secondly, it fetches the `kickstart.nvim` init file and places it in your `~/.config/nvim`. If any of the directories it needs already exists it will fail and does not auto-nuke stuff except the cloned nvim source on Linux.

## Why?

I wanted to have a single script I can run in my docker containers to have a basic Neovim setup.

## Modifying

You can always tweak your config in `~/.config/nvim/init.lua` to your liking.