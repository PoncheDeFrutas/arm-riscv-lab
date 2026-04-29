FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        binutils-aarch64-linux-gnu \
        ca-certificates \
        gdb-multiarch \
        gcc-aarch64-linux-gnu \
        git \
        make \
        qemu-user \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

CMD ["/bin/bash"]
