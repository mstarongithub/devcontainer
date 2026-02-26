FROM quay.io/toolbx/arch-toolbox:latest
ARG basePackages="git base-devel fish zellij bat ripgrep fd neovim starship thefuck eza fzf sd wl-clipboard tealdeer zoxide"
ARG extra

# Update packages and install base ones
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm --needed ${basePackages} ${extra}

# Get starship's prompt instead of the distrobox one
RUN echo "source (starship init fish --print-full-init | psub)" > /etc/fish/functions/fish_prompt.fish
# Always delete the fish prompt function from the distrobox created config. If it doesn't exist, do nothing
RUN echo "sudo sd '\tfunction fish_prompt\n.+\n.+\n.+end' '' /etc/fish/conf.d/distrobox_config.fish" > /etc/fish/conf.d/99_fuck_distrobox.fish

# Because directory bullshit and certs not being where they're supposed to be
RUN mkdir -p /etc/pki/ca-trust/extracted
RUN ln -s /etc/ca-certificates/extracted /etc/pki/ca-trust/extracted/pem

# Install yay
WORKDIR /tmp
RUN <<EOF
useradd -m -G wheel builder && passwd -d builder
echo 'builder ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
mkdir yay-build
chown -R builder:builder yay-build
su - builder -c "git clone https://aur.archlinux.org/yay.git /tmp/yay-build/yay"
su - builder -c "cd /tmp/yay-build/yay && makepkg -si --noconfirm"
userdel builder
rm -rf yay-build
EOF
