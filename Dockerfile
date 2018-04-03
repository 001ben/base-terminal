FROM tsl0922/ttyd:latest

# Install commonly used terminal packages
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    htop \
    zsh \
    man-db \
    tmux

# Install neovim from source
RUN apt-get install -y --no-install-recommends \
    make \
    cmake \
    g++ \
    pkg-config \
    python-dev \
    python-pip \
    python3-dev \
    python3-pip \
    unzip \
    libtool \
    libtool-bin \
    automake \
    ninja-build \
    autoconf \
    texinfo \
  && git clone --depth=1 https://github.com/neovim/neovim /tmp/neovim \
  && cd /tmp/neovim \
  && make && make install \
  && rm -rf /tmp/neovim

EXPOSE 7681

ENTRYPOINT ["ttyd"]

CMD ["tmux", "new", "-A", "-s", "ttyd", "/bin/zsh"]
