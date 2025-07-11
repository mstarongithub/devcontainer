FROM quay.io/toolbx/arch-toolbox:latest
ARG basePackages="fish zellij bat ripgrep fd neovim starship"
ARG extra

RUN pacman -Syu --noconfirm
RUN pacman --noconfirm -S --needed git base-devel
# WORKDIR /tmp
# RUN <<EOF
# runuser -u nobody -- git clone https://aur.archlinux.org/yay.git
# cd yay 
# runuser -u nobody -- makepkg -si --noconfirm
# EOF

# RUN yay -S --noconfirm ${basePackages} ${extra}
RUN pacman -S --noconfirm ${basePackages} ${extra}
