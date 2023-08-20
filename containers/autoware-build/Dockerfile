# docker build . -t ghcr.io/bounverif/autoware:build -f docker/autoware-humble/build.dockerfile
# docker run --rm -it ghcr.io/bounverif/autoware:build

FROM amd64/ros:humble

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
      git \
      wget \
      cmake \
      ccache \
      ninja-build \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* 

# RUN echo "deb [trusted=yes] http://packages.ros.org/ros2/ubuntu jammy main" > /etc/apt/sources.list.d/ros2-latest.list
RUN echo "deb [trusted=yes] https://s3.amazonaws.com/autonomoustuff-repo/ jammy main" > /etc/apt/sources.list.d/autonomoustuff-public.list

# install not-so-much-changed packages
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
      libboost-all-dev \
      libpcap-dev \
      # libopencv-dev \
      # libpcl-dev \
      # libcrypto++-dev \
      # libcpprest-dev \
      # libnl-3-dev \
      # libgoogle-glog-dev \
      # libgeographic-dev \
      # geographiclib-tools \
      ros-humble-rmw-fastrtps-cpp \
      ros-humble-rmw-cyclonedds-cpp \
      ros-humble-pacmod3 \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* 

RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb \
    && dpkg -i cuda-keyring_1.1-1_all.deb && rm cuda-keyring_1.1-1_all.deb

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
      cuda-minimal-build-12-2 \
      libcublas-dev-12-2 \
      libcurand-dev-12-2 \
      # cuda-libraries-dev-12-2 \
      # cuda-command-line-tools-12-2 \
      # libnccl-dev \
      libnvinfer-dev \
      libnvinfer-plugin-dev \
      libnvparsers-dev \
      libnvonnxparsers-dev \
    && find . -name 'libcu*.a' -delete \
    && find . -name 'libnv*.a' -delete \ 
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* 

RUN git clone https://github.com/autowarefoundation/autoware.git --depth 1 /autoware \
    && mkdir /autoware/src \
    && vcs import --shallow /autoware/src < /autoware/autoware.repos \
    && . /opt/ros/humble/setup.sh \
    && rosdep update \
    && apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && rosdep install -y \
      --from-paths /autoware/src \
      --ignore-src \
      --rosdistro humble \
      --dependency-types build \
      --dependency-types buildtool \
      --dependency-types test \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
    && rm -rf /autoware 

ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility 
ENV PATH="/usr/local/cuda/bin:$PATH"
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
ENV CMAKE_GENERATOR=Ninja
ENV CCACHE_DIR=/ccache

## BUILD ENVIRONMENT -- END
