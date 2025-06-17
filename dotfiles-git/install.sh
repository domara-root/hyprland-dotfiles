#!/bin/bash

read -p "Are you sure you want to run this? [y/N] " confirm
if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    tmpdir=$(mktemp -d) # make a temp dir
    curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/3270.zip -o "$tmpdir/3270.zip" # download da font
    unzip "$tmpdir/3270.zip" -d "$tmpdir" # put da shii in uhh i forgor 🥀 (temp folder)
    sudo cp -vr "$tmpdir/3270/" /usr/share/fonts/ # copy ts into fonts folder🥀🥀
    sudo fc-cache -fv # reload da font
    rm -rf "$tmpdir" # die temp dir


    sudo pacman -S fish hyprland waybar rofi kitty --noconfirm # install everything except a j*b application and the h*zz (we only pull bruzz)🥀🥀🥀
    echo -e "\e[31mCHANGING SHELL!!!\e[0m" # red text :3?
    sudo chsh -s /usr/bin/fish $USER # change the damn shell already

    # copy tiem
        cp -vr "$(pwd)/hypr" "$HOME/.config/hypr" 
        cp -vr "$(pwd)/rofi" "$HOME/.config/rofi"
        cp -vr "$(pwd)/kitty" "$HOME/.config/kitty"
        cp -vr "$(pwd)/waybar" "$HOME/.config/waybar"

    echo -e "\e[31mrestarting hyprland\e[0m" # restart hyprland
    sleep 3 # waiting tiem
    hyprctl dispatch exit # kil hyprlan
    hyprland # nvm he back 🤣🤣🤣🥀

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

    kitty @ launch --title="Kitty" bash -c 'cat instructions.txt; exec fish' # show it
else
    echo "aborted." # bro didnt install my dotfiles 💀💀💀
    exit 1 # bye 🥀🥀🥀
fi
