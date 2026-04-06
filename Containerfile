FROM fedora:41

RUN dnf install -y \
    nodejs \
    npm \
    git \
    python3 \
    python3-pip \
    make \
    gcc \
    gcc-c++ \
    ripgrep \
    fd-find \
    jq \
    curl \
    wget \
    unzip \
    && dnf clean all

RUN npm install -g @anthropic-ai/claude-code

RUN useradd -m -u 1000 claude
USER claude
WORKDIR /workspace

ENTRYPOINT ["claude"]
CMD ["--dangerously-skip-permissions"]