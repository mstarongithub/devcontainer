FROM quay.io/fedora/fedora-toolbox:latest
# sd not available in either fedora nor copr
ARG basePackages="git fish zellij bat ripgrep fd-find neovim starship thefuck eza fzf wl-clipboard tealdeer zoxide"
ARG coprs="atim/starship sramanujam/atuin varlad/zellij alternateved/eza"
ARG extra

# Update packages and install base ones
RUN dnf update -y
RUN for i in ${coprs}; do dnf copr enable -y "$i"; done
RUN dnf install -y ${basePackages} ${extra}

# Get starship's prompt instead of the distrobox one
RUN echo "source (starship init fish --print-full-init | psub)" > /etc/fish/functions/fish_prompt.fish
# Always delete the fish prompt function from the distrobox created config. If it doesn't exist, do nothing
RUN echo "sudo sd '\tfunction fish_prompt\n.+\n.+\n.+end' '' /etc/fish/conf.d/distrobox_config.fish" > /etc/fish/conf.d/99_fuck_distrobox.fish
