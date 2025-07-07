#!/bin/bash

if [ -f /etc/debian_version ]; then
    DISTRO="debian"
elif [ -f /etc/fedora-release ]; then
    DISTRO="fedora"
elif command -v pacman &>/dev/null; then
    DISTRO="arch"
else
    echo "unsupported distro, supported types: "
    echo "arch based, debian based, fedora based"
    exit 1
fi

read -p "Are you sure you want to run this? [y/N] " confirm

if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    case "$DISTRO" in
        arch)
            sudo pacman -S fish hyprland waybar rofi kitty fastfetch dolphin hyprpaper hyprshot ttf-3270-nerd --noconfirm --needed
            ;;
        debian)
            sudo apt update
            sudo apt install -y fish hyprland waybar rofi kitty fastfetch dolphin
            # hyprshot + hyprpaper may not exist; might need to build or use alternatives
            ;;
        fedora)
            sudo dnf install -y fish hyprland waybar rofi kitty fastfetch dolphin
            # same note as debian
            ;;
    esac

    mkdir $HOME/.dotfiles
    cp wallpaper.png $HOME/.dotfiles

    cp logo.png $HOME/.config/fastfetch

    echo -e "\e[31mCHANGING SHELL!!!\e[0m" # red text :3?
    sudo chsh -s /usr/bin/fish $USER # change the damn shell already

    # copy tiem
        cp -vr "$(pwd)/hypr" "$HOME/.config" 
        cp -vr "$(pwd)/rofi" "$HOME/.config"
        cp -vr "$(pwd)/kitty" "$HOME/.config"
        cp -vr "$(pwd)/waybar" "$HOME/.config"
        cp -vr "$(pwd)/fastfetch" "$HOME/.config"

    touch instructions.txt # make an instructions file

    # sending text to the file (bro yapping 🤣🤣🤣)
cat > instructions.txt << 'EOF'
Hey, thanks for downloading! There's a few key keybinds (no pun intended) that are required to know in order to use Hyprland.

Super + Q:  Opens Kitty (terminal emulator)
Super + C:  Closes focused program
Super + E:  Opens Dolphin
Super + V:  Toggles floating window
Super + J:  Toggles split

Alt + F4 + R:  Reboot
Alt + F4 + S:  Shutdown
Alt + F4 + L:  Logout

Print Screen:  Screenshot whole screen
Shift + Print Screen:  Screenshot region of screen
Super + Print Screen:  Screenshot window

Alt + Space:  App launcher (Rofi)

Super + 0-9:  Workspaces 0-9
Super + Shift + 0-9:  Move focused window to workspaces 0-9

Super + Alt + F:  Opens Firefox

To see more binds, check ~/.config/hypr/hyprland.conf, starting at line 127
EOF
# bro unindented it for what ^ 🤣🤣🤣🤣🤣🤣🤣🤣🤣

    kitty @ launch bash -c 'cat instructions.txt; exec fish' # show it
else
    echo "aborted." # bro didnt install my dotfiles 💀💀💀
    exit 1 # bye 🥀🥀🥀
fi
