# Neovimugicha  
Neovim distro since I don't want to configure it everywhere separately, comes with it's own theme **based theme**

## Install  
Global dependencies for **Arch** or **Gentoo**:  

**Arch:**  
```sh
sudo pacman -S neovim \
               nodejs \
               npm \
               unzip \
               ripgrep \
               fd \
               texlive-binextra \
               texlive-latex \
               texlive-latexextra \
               texlive-latexrecommended \
               texlive-mathscience \
               texlive-fontsextra \
               zathura \
               git \
               github-cli
```


**Gentoo:**
```sh
sudo emerge -av app-editors/neovim \
               net-libs/nodejs \
               app-arch/unzip \
               sys-apps/ripgrep \
               sys-apps/fd \
               app-text/texlive \
               app-text/zathura \
               dev-vcs/git \
               dev-util/github-cli
 

```

Once you have the global deps run this

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Jason-Goon/neovimugicha/master/setup.sh)"
```

To delete the configuration for uninstall or before install if any nvim dotfiles exist 

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Jason-Goon/neovimugicha/master/cleanup.sh)"
```


## Features

- **Lazy.nvim** for plugin management  
- **Nvim-Tree** file browser – `<Space>e` to toggle  
- **Treesitter** syntax highlighting  
- **LSP support** – Rust, C, C++, Python, TypeScript, HTML, CSS  
- **Git/ copilot integration**  
- **Based Theme**  
- **LaTeX support with vimtex** – Live preview via Zathura  
- **GitHub Copilot integration** – `<Space>co` to toggle  
- **ASCII art start screen**  
- **Quick project setup for Math, Notes, and Assignments**  
- **Standalone configuration files pulled from GitHub**  


## Keybinds

- `<Space>e` → Toggle file tree (Nvim-Tree)  
- `<Space>q` → Close buffer  
- `<Space>w` → Save file  
- `<Space>co` → Toggle GitHub Copilot  
- `:NewMathProject <name>` → Create a new Math project  
- `:NewNotes <name>` → Create a new Notes project  
- `:NewAssignment <name>` → Create a new Assignment project  


## Notes  

- **To reset or uninstall**, run `cleanup.sh`.  
- **If a plugin doesn’t load**, run `:Lazy sync` inside Neovim.  
- **LSPs should install automatically** via Mason. If missing, verify dependencies.  
- **System dependencies must be installed manually** before running Neovim.  

