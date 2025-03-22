FROM debian:bullseye-backports

# [Optional] Uncomment this section to install additional packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends build-essential=12.9 \
    rsync gdb zip python3=3.9.2-3 python3-pip ninja-build \
    cppcheck valgrind lldb llvm gdb curl libcurl4-openssl-dev libssl-dev\
    wget checkinstall zlib1g-dev git

# Install cmake
RUN mkdir dependencies && cd dependencies && \
    wget https://github.com/Kitware/CMake/releases/download/v3.27.1/cmake-3.27.1.tar.gz && \
    tar -xf cmake-3.27.1.tar.gz && \
    cd cmake-3.27.1 && \
    ./bootstrap --parallel=10 && \
    gmake -j10 && \
    make install && \
    cd .. && cd .. && rm -r dependencies

# Switching to a non-root user, please refer to https://aka.ms/vscode-docker-python-user-rights
ARG USERNAME=develop
ARG USER_UID=1001
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME
ENV HOME="/home/$USERNAME"
ENV PATH="$PATH:$HOME/.local/bin"
ENV IS_CONTAINER="yes"
ENV CONTAINER_NAME="Debian-11"
WORKDIR $HOME

RUN mkdir $HOME/.conan2 && chown -R $USER_UID:$USER_GID $HOME/.conan2
RUN pip3 install --no-cache-dir --user conan==2.14.0

#CMD ["/bin/bash"]