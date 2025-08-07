FROM quay.io/toolbx/arch-toolbox:latest
ARG basePackages="git base-devel fish zellij bat ripgrep fd neovim starship thefuck eza fzf sd wl-clipboard tealdeer"
ARG extra

# Update packages and install base ones
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm --needed ${basePackages} ${extra}

# Get starship's prompt instead of the distrobox one
RUN echo "source (starship init fish --print-full-init | psub)" > /etc/fish/functions/fish_prompt.fish
# Always delete the fish prompt function from the distrobox created config. If it doesn't exist, do nothing
RUN echo \"sudo sd '\tfunction fish_prompt\n.+\n.+\n.+end' '' /etc/fish/conf.d/distrobox_config.fish\" > /etc/fish/conf.d/99_fuck_distrobox.fish

# Install yay, disabled b/c broken makepkg
# WORKDIR /tmp
# RUN <<EOF
# runuser -u nobody -- git clone https://aur.archlinux.org/yay.git
# cd yay 
# runuser -u nobody -- makepkg -si --noconfirm
# EOF

# RUN yay -S --noconfirm ${basePackages} ${extra}
