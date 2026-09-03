FROM quay.io/toolbx-images/debian-toolbox:testing

ARG basePackages="neovim git fish bat ripgrep fd-find starship thefuck eza fzf sd wl-clipboard tealdeer zoxide just"
ARG extra

RUN apt update && apt upgrade -y

RUN apt install -y ${basePackages} ${extra}

