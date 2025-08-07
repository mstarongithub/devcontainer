FROM quay.io/toolbx/arch-toolbox:latest
ARG basePackages="git base-devel fish zellij bat ripgrep fd neovim starship thefuck eza fzf sd wl-clipboard tealdeer"
ARG extra

# Update packages and install base ones
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm --needed ${basePackages} ${extra}

# Replace Distrobox's prompt with starship
# Actually doesn't work since Distrobox's config only gets inserted during container creation
# RUN sd '\tfunction fish_prompt\n.+\n.+\n\tend' "\tsource (starship init fish --print-full-init | psub)" /etc/fish/conf.d/distrobox_config.fish
RUN echo "source (starship init fish --print-full-init | psub)" > /etc/fish/functions/fish_prompt.fish

# Install yay, disabled b/c broken makepkg
# WORKDIR /tmp
# RUN <<EOF
# runuser -u nobody -- git clone https://aur.archlinux.org/yay.git
# cd yay 
# runuser -u nobody -- makepkg -si --noconfirm
# EOF

# RUN yay -S --noconfirm ${basePackages} ${extra}
