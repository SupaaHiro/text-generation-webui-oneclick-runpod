FROM ubuntu:24.04

ARG APTPKGS="wget curl vim git tmux tldr nvtop neovim rsync net-tools less iputils-ping 7zip zip unzip make ca-certificates"

EXPOSE 7860
EXPOSE 5000

ENV DEBIAN_FRONTEND=noninteractive
ENV GPU_CHOICE=A
ENV USE_CUDA118=0

# Install useful command line utility software
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends $APTPKGS && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install git-lfs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up git to support LFS, and to store credentials; useful for Huggingface Hub
RUN git config --global credential.helper store && \
    git lfs install

# Download and install miniconda
RUN wget -O miniconda-install.sh https://repo.anaconda.com/miniconda/Miniconda3-py39_24.5.0-0-Linux-x86_64.sh
RUN chmod +x ./miniconda-install.sh && ./miniconda-install.sh -b -m && rm ./miniconda-install.sh

WORKDIR /app

RUN git clone https://github.com/oobabooga/text-generation-webui.git . && git checkout v1.13
RUN chmod +x ./start_linux.sh && LAUNCH_AFTER_INSTALL=n ./start_linux.sh

COPY scripts/start.sh .
RUN chmod +x start.sh

ENTRYPOINT ["sh", "-c"]
CMD ["./start.sh"]