#!/bin/bash

read -p "Are you sure you want to run this? [y/N] " confirm
if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    if ! command -v pacman &>/dev/null; then
        # laugh at non arch users for trying to install this even tho i told them in the readme you cant do it unless u have arch
            echo "bruhhh this dood tried to install this with no arch"
            echo "failure to read! laugh at this user."
            echo "manual install instructions:"
            echo "  fish, hyprland, waybar, rofi, kitty, fastfetch"
            exit 1
    else
        sudo pacman -S fish hyprland waybar rofi kitty fastfetch dolphin --noconfirm --needed # install everything except a j*b application and the h*zz (we only pull bruzz)🥀🥀🥀
    fi

    if ! command -v yay &>/dev/null; then
        echo "yay not found. installing..."
    
        # make sure required tools are there
        sudo pacman -S --needed --noconfirm base-devel git
    
        # clone and build yay
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay || exit 1
        makepkg -si --noconfirm
    
        cd ..
    fi

    yay -S hyprpaper hyprshot ttf-3270-nerd

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

    echo -e "\e[31mrestarting hyprpaper and waybar (if not started)\e[0m" # restart stuff
    pkill waybar; pkill hyprpaper; # send them to heaven
    waybar 

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
