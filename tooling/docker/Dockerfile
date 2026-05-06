FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        bsdextrautils \
        binutils-aarch64-linux-gnu \
        ca-certificates \
        file \
        gdb-multiarch \
        gcc-aarch64-linux-gnu \
        git \
        make \
        qemu-user \
        strace \
        xxd \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

CMD ["/bin/bash"]
