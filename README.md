# dotfiles

My personal dotfiles for macOS. Clean, minimal, and optimized for productivity.

![macOS](https://img.shields.io/badge/macOS-000000?style=flat&logo=apple&logoColor=white)
![Zsh](https://img.shields.io/badge/Zsh-F15A24?style=flat&logo=zsh&logoColor=white)
![Neovim](https://img.shields.io/badge/Neovim-57A143?style=flat&logo=neovim&logoColor=white)
![WezTerm](https://img.shields.io/badge/WezTerm-4E49EE?style=flat&logo=wezterm&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=flat&logo=git&logoColor=white)
![Lazygit](https://img.shields.io/badge/Lazygit-F05032?style=flat&logo=git&logoColor=white)
![Lazydocker](https://img.shields.io/badge/Lazydocker-2496ED?style=flat&logo=docker&logoColor=white)
![VS Code](https://img.shields.io/badge/VS%20Code-007ACC?style=flat&logo=visualstudiocode&logoColor=white)

## ✨ What's Included

| Tool | Description |
|------|-------------|
| **Zsh** | Shell config with [Powerlevel10k](https://github.com/romkatv/powerlevel10k) prompt |
| **Neovim** | [LazyVim](https://www.lazyvim.org/) setup for a modern editing experience |
| **[WezTerm](https://wezfurlong.org/wezterm/)** | GPU-accelerated terminal with iTerm2-style keybindings |
| **[Karabiner](https://karabiner-elements.pqrs.org/)** | Caps Lock → Hyper Key (⌘⌃⌥⇧) |
| **[Git](https://git-scm.com/)** | Global config with sensible defaults |
| **[Lazygit](https://github.com/jesseduffield/lazygit)** | Terminal UI for git commands |
| **[Lazydocker](https://github.com/jesseduffield/lazydocker)** | Terminal UI for Docker management |
| **[VS Code](https://code.visualstudio.com/)** | Minimal, distraction-free UI settings |

## 🚀 Quick Start

```bash
# Clone the repo
git clone https://github.com/nicowenterodt/dotfiles.git ~/dotfiles

# Run the install script
cd ~/dotfiles && chmod +x install.sh && ./install.sh
```

The install script is **idempotent** — safe to run multiple times.

## ⌨️ Key Bindings

### WezTerm
| Shortcut | Action |
|----------|--------|
| `⌘ D` | Split pane horizontally |
| `⌘ ⇧ D` | Split pane vertically |
| `⌘ W` | Close pane |
| `⌘ ⌥ ←↑↓→` | Navigate between panes |

### Karabiner
| Shortcut | Action |
|----------|--------|
| `Caps Lock` | Hyper Key (⌘⌃⌥⇧) |

## 📁 Structure

```
dotfiles/
├── install.sh          # Symlink setup script
├── Brewfile            # Homebrew packages
├── git/                # Git configuration
├── karabiner/          # Keyboard customization
├── nvim/               # Neovim (LazyVim)
├── vscode/             # VS Code settings
├── wezterm/            # Terminal configuration
└── zsh/                # Shell configuration
```

## 🍺 Homebrew Packages

Managed via `Brewfile`:

- **CLI:** git, lazygit, lazydocker, neovim, powerlevel10k
- **Apps:** Rectangle, Karabiner Elements
- **Fonts:** Hack Nerd Font

## 🎨 Theme

- **Terminal:** Catppuccin Mocha
- **Font:** Hack Nerd Font (14pt)
- **VS Code:** Night Owl

## ⚙️ Post-Install

1. **Set up Git profile:**
   ```bash
   nvim ~/dotfiles/git/.gitconfig.local
   ```


2. **Install Homebrew** (if not installed):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

3. **Restart your terminal** to apply all changes.
