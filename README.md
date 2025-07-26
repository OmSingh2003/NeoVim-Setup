# NeoVim Setup

My personal NeoVim and Tmux configuration files.

## Contents

- `nvim/` - NeoVim configuration directory
- `.tmux.conf` - Tmux configuration file
- `.tmux/` - Additional tmux configuration files

## Installation

### NeoVim Configuration
```bash
# Backup your existing nvim config (if any)
mv ~/.config/nvim ~/.config/nvim.backup

# Copy the nvim configuration
cp -r nvim ~/.config/
```

### Tmux Configuration
```bash
# Backup your existing tmux config (if any)
mv ~/.tmux.conf ~/.tmux.conf.backup
mv ~/.tmux ~/.tmux.backup

# Copy the tmux configuration
cp .tmux.conf ~/
cp -r .tmux ~/
```

## Requirements

- NeoVim (latest version recommended)
- Tmux
- Git

## Features

This setup includes my customized configurations for both NeoVim and Tmux, optimized for development workflow.
