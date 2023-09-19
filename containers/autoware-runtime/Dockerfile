FROM ghcr.io/bounverif/autoware-prebuilt:latest as prebuilt
FROM ros:humble-ros-base-jammy

ARG CUDA_ARCH=x86_64
ARG CUDA_DISTRO=ubuntu2204
ARG CUDA_KEYRING_PACKAGE=cuda-keyring_1.1-1_all.deb
ARG CUDA_KEYRING_FILEPATH=https://developer.download.nvidia.com/compute/cuda/repos/${CUDA_DISTRO}/${CUDA_ARCH}/${CUDA_KEYRING_PACKAGE}

ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility 

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
      git \
      wget \
      tini \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* 

RUN wget ${CUDA_KEYRING_FILEPATH} && dpkg -i ${CUDA_KEYRING_PACKAGE} && rm ${CUDA_KEYRING_PACKAGE}

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
      libcublas-12-2 \
      libcurand-12-2 \
      cuda-cudart-12-2 \
      libnvinfer8 \
      libnvinfer-plugin8 \
      libnvparsers8 \
      libnvonnxparsers8 \
    && find . -name 'libcu*.a' -delete \
    && find . -name 'libnv*.a' -delete \ 
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* 

# Copy Autoware build artifacts
COPY --from=prebuilt /opt/autoware/humble /opt/autoware/humble

# Copy the script to the container
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

# Tini correctly initialize the shell in the container
# With the -g option, tini kills the child process group.
# This corresponds more closely to what happens when you do ctrl-C
# See: https://github.com/krallin/tini
ENTRYPOINT ["tini", "-g", "--", "/entrypoint.sh"]
