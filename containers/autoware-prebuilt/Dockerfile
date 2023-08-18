FROM ghcr.io/bounverif/autoware-build:latest

RUN git clone https://github.com/autowarefoundation/autoware.git --depth 1 /autoware \
    && mkdir /autoware/src \
    && vcs import --shallow /autoware/src < /autoware/autoware.repos \
    && . /opt/ros/humble/setup.sh \
    && colcon build \
      --base-paths /autoware/src \
      --symlink-install \ 
      --cmake-args -DCMAKE_BUILD_TYPE=Release 
