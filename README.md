# Neovimugicha  
Neovim distro since I don't want to configure it everywhere separately, comes with it's own theme **based theme**

## Install  
Global dependencies for **Arch** or **Gentoo**:  

**Arch:**  
```sh
sudo pacman -S nodejs npm unzip ripgrep fd texlive-most zathura
```

**Gentoo:**
```sh
sudo emerge -av net-libs/nodejs app-arch/unzip sys-apps/ripgrep sys-apps/fd app-text/texlive app-text/zathura

```

Once you have the global deps run this

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Jason-Goon/neovimugicha/master/setup.sh)"
```


Features

    Lazy.nvim for plugin management 
    Nvim-Tree file browser – <Space>e to toggle it
    Treesitter syntax highlighting 
    LSP support – Rust, C, C++, Python, TypeScript, HTML, CSS
    Git integration 
    Based Theme

Keybinds

    <Space>e → Toggle file tree (nvim-tree)
    <Space>q → Close buffer
    <Space>w → Save file

Notes

    If Mason fails to install LSPs, run :Mason in neovim and check :MasonLog.
    Run cleanup.sh if you want a clean reinstall or delete.
    If a plugin doesn’t load, run :Lazy 
