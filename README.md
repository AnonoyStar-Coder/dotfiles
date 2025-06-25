# 🌿 Ballu's Dotfiles – *"I Use NixOS, Btw" Edition*

> *"If it ain't riced, it's just plain boiled."*  
> — Ancient NixOS proverb probably

Welcome to **my dotfiles**, a cursed-yet-beautiful blend of `nix`, `flakes`, `home-manager`, and enough Gruvbox to blind a GTK3 theme engine. This setup is as modular as my attention span, and twice as hackable.

## 🧬 What is this?

This is my NixOS configuration powered by flakes, home-manager, and sheer will. It's where I summon my ricing rituals, summon Spotify demons, and configure my terminal to look like it came out of a vaporwave forest.

---

## 📁 File/Folder Breakdown — aka "What in the rice is this?"

Here's a lovingly sarcastic breakdown of each moving part:

### 📦 `flake.nix` + `flake.lock`
- The divine entry point of this cult.
- Pins all the packages and inputs so my future self doesn’t scream when rebuilding in 2026.
- Uses `nixos-25.05` and Home Manager `release-25.05` because I like to live dangerously (but reproducibly).

### 🏗️ `configuration.nix`
- System-wide config.
- Tells NixOS who I am (`balraj`) and gives me **sudo powers** (mwahaha).
- Configures Qtile, LightDM, PipeWire, Docker, and all that jazz.
- Home Manager is imported here too, but it only handles user stuff like a well-behaved daemon.

### 👤 `home.nix`
- Where the vibes really begin.
- Installs all my user packages: `neovim`, `tmux`, `spotify`, `rofi`, etc.
- Declares wallpapers, theme files, terminal configs, and more.
- If `configuration.nix` is the skeleton, this is the soul (and the drip).

### 🐚 `.bashrc` + `.bash-alias`
- Bash, but with more flavor.
- Aliases that range from practical to totally unnecessary.
- Possibly a secret `rm -rf` shortcut just for thrills. (jk... or am I?)

### 🎨 `.theme.omp.json`
- Custom theme for `oh-my-posh` because I want my prompt to say "Ballu was here."

### 🧥 `.themes/`
- Houses GTK themes — currently rocking `Gruvbox-Dark` 'cause light themes are for the weak.

### 🖥️ `qtile/`
- My window manager config.
- Probably 97% stolen, 3% sprinkled with emotional damage from debug sessions.
- Contains multiple `config.py.bak.*` because naming is hard.

### 🖼️ `walls/`
- My **holy wallpapers**.
- Includes `castle.jpg`, `sunset.png`, and `snake.png` because apparently, I like medieval nostalgia, soft nihilism, and reptiles.
- Symlinked to `/etc/lightdm/backgrounds` because why not.

### 🔥 `rofi/`, `kitty/`, `alacritty/`, `spotify-player/`
- All my config folders, neatly tucked in.
- Terminal emulators, launchers, music players... all themed like it’s 3AM and I’m on my 4th cup of chai.
- RoFi themes make me feel like a hacker in a K-drama.

### 📚 `README.md`
- You're reading it. So meta.
- Yes, it was written by ChatGPT, but with **my vibes**.

---

## ⚙️ How to Use This Sorcery

> _Warning: Use at your own risk. May cause over-customization and excessive pride._

### 💾 Clone the repo:

```bash
git clone https://github.com/AnonoyStar-Coder/dotfiles.git ~/dotfiles
cd ~/dotfiles
make the changes according to your needs (like please change the username atleast....)
run "sudo nixos-rebuild switch --flake ."
reboot

✨ Features

    🧠 Flake-based setup with locked inputs

    👤 Home Manager for clean user-level configs

    🎨 Gruvbox everywhere (even the shadows are gruvboxed)

    🎧 PipeWire + Spotify-Player + Librespot

    💻 Qtile + LightDM + Wallpapers = Desktop flex

    🐚 Bash aliases so I never have to type cd .. again

    📦 Everything in one repo — pure, modular, and chaos-ready™

❓Why Tho?

Because vanilla is for ice cream, not Linux.
📜 License

    If you find this useful, give it a star ⭐.
    If you break your system copying it, that's on you 😇.

    Built with love, rage, and nixos-rebuild failures.