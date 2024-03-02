# docker build . -t ghcr.io/bounverif/autoware:build -f docker/autoware-humble/build.dockerfile
# docker run --rm -it ghcr.io/bounverif/autoware:build

FROM ros:humble-ros-base-jammy

VOLUME [ "/autoware_maps" ]

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
      python3 \
      python3-pip \
      unzip \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
    && pip install gdown

RUN gdown -O /autoware_maps/ 'https://github.com/tier4/AWSIM/releases/download/v1.1.0/nishishinjuku_autoware_map.zip' \
    && unzip -d /autoware_maps /autoware_maps/nishishinjuku_autoware_map.zip \
    && rm -rf /autoware_maps/nishishinjuku_autoware_map.zip  

RUN gdown -O /autoware_maps/ 'https://github.com/tier4/AWSIM/releases/download/v1.2.0/shinjuku_map.zip' \
    && unzip -d /autoware_maps /autoware_maps/shinjuku_map.zip \
    && rm -rf /autoware_maps/shinjuku_map.zip  

RUN gdown -O /autoware_maps/ 'https://drive.google.com/uc?export=download&id=1499_nsbUbIeturZaDj7jhUownh5fvXHd' && \
    unzip -d /autoware_maps /autoware_maps/sample-map-planning.zip && \
    rm -rf /autoware_maps/sample-map-planning.zip