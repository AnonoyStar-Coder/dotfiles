# 🌿 Ballu's Dotfiles – "I Use NixOS, Btw" Edition 🚀

> *"If it ain't riced, it's just plain boiled."*  
> — Ancient NixOS proverb (probably)

Welcome to **my dotfiles**, a meticulously crafted yet delightfully chaotic blend of `Nix`, `flakes`, `home-manager`, and enough Gruvbox to make your eyes sing. This setup is designed for maximum modularity, reproducibility, and aesthetic pleasure.

---

## ✨ Features & Highlights

This repository encapsulates my complete NixOS configuration, built with a focus on:

-   🧠 **Flake-based Setup**: Reproducible and declarative system configuration with locked inputs for consistent builds.
-   🏡 **Home Manager Integration**: Seamless management of user-specific configurations and packages.
-   🎨 **Gruvbox Everywhere**: A consistent, warm, and dark color scheme applied across all applications and terminals.
-   🎧 **Audio & Media**: PipeWire for advanced audio management, integrated with `spotify-player` and `librespot`.
-   🖥️ **Desktop Environment**:
    -   **Qtile**: A dynamic, Python-based tiling window manager for an efficient workflow.
    -   **LightDM**: Lightweight display manager with custom theming.
    -   **Wallpapers**: A curated collection of high-quality wallpapers, dynamically managed.
-   🐚 **Enhanced Shell Experience**: Custom `.bashrc` and `.bash-alias` for powerful shortcuts and a personalized prompt with `oh-my-posh`.
-   🚀 **Essential Applications**: Pre-configured `neovim`, `tmux`, `rofi`, `kitty`, `alacritty`, and more, all harmonized with the Gruvbox theme.

---

## 📁 Repository Structure — A Deep Dive

Here's a detailed breakdown of the key files and directories within this repository:

-   `flake.nix` & `flake.lock`: The heart of the setup, defining system inputs and ensuring reproducible builds.
-   `configuration.nix`: The main NixOS system configuration, handling core services, hardware, and system-wide settings.
-   `home.nix`: Manages user-specific configurations, including installed packages, themes, and application settings via Home Manager.
-   `.bashrc` & `.bash-alias`: Custom Bash configurations for aliases, functions, and environment variables.
-   `.theme.omp.json`: Configuration for `oh-my-posh`, defining the appearance of the shell prompt.
-   `alacritty/`: Configuration files for the Alacritty GPU-accelerated terminal emulator.
-   `kitty/`: Configuration files for the Kitty terminal emulator.
-   `modules/`: Contains modular Nix expressions for various configurations (e.g., `configs.nix`, `gtk.nix`, `packages.nix`, `shell.nix`).
-   `qtile/`: Qtile window manager configuration, including Python scripts for layouts, keybindings, and widgets.
-   `rofi/`: Rofi application launcher configurations and themes, including `gruvbox-dark.rasi`.
-   `spotify-player/`: Configuration for the `spotify-player` CLI client.
-   `walls/`: A collection of wallpapers used across the system.

---

## 🚀 Getting Started — Unleash the Power of NixOS

> *Warning: Use at your own risk. May cause extreme customization and excessive pride.*

1.  **Clone the Repository**:
    ```bash
    git clone https://github.com/AnonoyStar-Coder/dotfiles.git ~/dotfiles
    cd ~/dotfiles
    ```

2.  **Customize (Important!)**:
    Before applying, **please review and modify** the configurations to suit your specific needs. At a minimum, you'll want to change the username and any hardware-specific settings in `configuration.nix` and `home.nix`.

3.  **Apply the Configuration**:
    ```bash
    sudo nixos-rebuild switch --flake .#your-hostname # Replace 'your-hostname' with your actual hostname
    ```
    *(If you don't have a specific hostname defined in your flake, you can use `sudo nixos-rebuild switch --flake .`)*

4.  **Reboot**:
    ```bash
    reboot
    ```
    After rebooting, your system should be running with the new NixOS configuration!

---

## ❓ Why NixOS?

Because vanilla is for ice cream, not Linux. NixOS offers unparalleled reproducibility, atomic upgrades, and a declarative approach to system management that makes configuring your environment a joy (mostly!).

---

## 📜 License

If you find this useful, give it a star ⭐.  
If you break your system copying it, that's on you 😇.

Built with love, rage, and occasional `nixos-rebuild` failures.
