# dotfiles

Personal dotfiles for macOS. Clean, minimal, and optimized for productivity.

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
| **[Zsh](https://www.zsh.org/)** | Shell with [Oh My Zsh](https://ohmyz.sh/) + [Powerlevel10k](https://github.com/romkatv/powerlevel10k) |
| **[Neovim](https://neovim.io/)** | [LazyVim](https://www.lazyvim.org/) setup for a modern editing experience |
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
cd ~/dotfiles && ./install.sh
```

The install script is **idempotent** — safe to run multiple times without breaking your setup.

### What the Install Script Does

- Installs [Oh My Zsh](https://ohmyz.sh/) if not present
- Creates symlinks for all configuration files
- **Automatically backs up** existing configs to `~/.dotfiles_backup/YYYY-MM-DD_HH-MM-SS/`
- Installs Homebrew packages from Brewfile
- Validates installation and reports status
- Detects script location (doesn't have to be in `~/dotfiles`)

All backups are kept indefinitely - you can manually clean them up when needed.

## ⌨️ Key Bindings

### WezTerm
| Shortcut | Action |
|----------|--------|
| `⌘ D` | Split pane horizontally |
| `⌘ ⇧ D` | Split pane vertically |
| `⌘ W` | Close pane |
| `⌘ ⌥ ←↑↓→` | Navigate between panes |
| `⌘ ⌥ h/j/k/l` | or with vim motions |

### Karabiner Elements

Two profiles configured for different keyboard types:

| Profile | Keyboard Type | Description |
|---------|---------------|-------------|
| **default** | ANSI | For MacBook built-in keyboard |
| **external** | ISO | For mechanical external keyboards |

Both profiles include:
| Shortcut | Action |
|----------|--------|
| `Caps Lock` | Hyper Key (⌘⌃⌥⇧) |

**Switching profiles:** Open Karabiner-Elements preferences → Select "Profiles" tab → Choose your profile

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
   Add your name and email:
   ```ini
   [user]
       name = Your Name
       email = your.email@example.com
   ```

2. **Select Karabiner profile:**
   - Open Karabiner-Elements
   - Go to Profiles tab
   - Select "default" for MacBook keyboard or "external" for ISO mechanical keyboard

3. **Install Homebrew** (if not installed):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

4. **Restart your terminal** to apply all changes.

## 🔧 Troubleshooting

### Symlinks not working
The install script validates all symlinks. If you see errors, check:
```bash
ls -la ~/.zshrc
ls -la ~/.config/nvim
```
Symlinks should point to your dotfiles directory.

### Backups location
All backups are stored in `~/.dotfiles_backup/` with timestamps:
```bash
ls -la ~/.dotfiles_backup/
```

### VS Code settings not applied
The script symlinks both `settings.json` and `keybindings.json` (if present):
- Settings: `~/Library/Application Support/Code/User/settings.json`
- Keybindings: `~/Library/Application Support/Code/User/keybindings.json`

If VS Code is running, restart it after installation.

### Re-running the install script
Safe to run multiple times! The script:
- Skips if symlinks already point to dotfiles
- Only backs up files that aren't already symlinks to dotfiles
- Won't reinstall Oh My Zsh if it exists
