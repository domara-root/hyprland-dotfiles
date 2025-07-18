#!/bin/bash

read -p "Are you sure you want to run this? [y/N] " confirm

if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    if command -v pacman &>/dev/null; then
        sudo pacman -Syy fish hyprland waybar rofi kitty fastfetch dolphin hyprpaper hyprshot ttf-3270-nerd --noconfirm --needed
    elif command -v dnf &>/dev/null; then
        sudo dnf update -y
        # dependencies for hyprpaper/hyprshot building/installing
        sudo dnf install cargo cmake rust wayland-devel wayland-protocols-devel hyprlang-devel pango-devel cairo-devel file-devel libglvnd-devel libglvnd-core-devel libjpeg-turbo-devel libwebp-devel libjxl-devel gcc-c++ hyprutils-devel hyprwayland-scanner libnotify wl-clipboard slurp grim jq -y 
        
        # the big stuff
        sudo dnf install kitty rofi waybar fastfetch dolphin hyprland ttf-3270-nerd git -y

        # build hyprpaper
        git clone https://github.com/hyprwm/hyprpaper
        cd hyprpaper 

        cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
        cmake --build ./build --config Release --target hyprpaper -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

        cmake --install ./build

        cd ..
        rm -rf hyprpaper

        git clone https://github.com/Gustash/hyprshot.git $HOME/.Hyprshot
        mkdir -p "$HOME/.local/bin"
        ln -sf "$HOME/.Hyprshot/hyprshot" "$HOME/.local/bin/"
        chmod +x $HOME/.Hyprshot/hyprshot
    elif command -v zypper &>/dev/null; then
        sudo zypper refresh
        sudo zypper install kitty rofi waybar fastfetch dolphin hyprland hyprpaper ttf-3270-nerd -y

        git clone https://github.com/Gustash/hyprshot.git $HOME/.Hyprshot
        mkdir -p "$HOME/.local/bin"
        ln -sf "$HOME/.Hyprshot/hyprshot" "$HOME/.local/bin/"
        chmod +x $HOME/.Hyprshot/hyprshot
    else
        echo "unsupported distro; supported distros: arch-based, fedora-based, and opensuse"
        exit 1           
    fi
    
    mkdir -p "$HOME/.dotfiles"
    cp wallpaper.png $HOME/.dotfiles

    echo -e "\e[31mCHANGING SHELL!!!\e[0m" # red text :3?

    # change the damn shell already
        if ! chsh -s /usr/bin/fish $USER; then
            sudo chsh -s /usr/bin/fish $USER
        fi

    # copy tiem
        script_dir="$(dirname "$(realpath "$0")")" # gets script dir

        cp -vr "$script_dir/hypr" "$HOME/.config"
        cp -vr "$script_dir/rofi" "$HOME/.config"
        cp -vr "$script_dir/kitty" "$HOME/.config"
        cp -vr "$script_dir/waybar" "$HOME/.config"
        cp -vr "$script_dir/fastfetch" "$HOME/.config"

        # old method of copying files
            # cp -vr "$(pwd)/hypr" "$HOME/.config" 
            # cp -vr "$(pwd)/rofi" "$HOME/.config"
            # cp -vr "$(pwd)/kitty" "$HOME/.config"
            # cp -vr "$(pwd)/waybar" "$HOME/.config"
            # cp -vr "$(pwd)/fastfetch" "$HOME/.config"

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

    kitty bash -c 'cat instructions.txt; exec fish' # show it
else
    echo "aborted." # bro didnt install my dotfiles 💀💀💀
    exit 1 # bye 🥀🥀🥀
fi


# remove this comment when done testing
