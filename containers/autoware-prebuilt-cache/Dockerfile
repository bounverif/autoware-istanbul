FROM ghcr.io/bounverif/autoware-build:latest as prebuilt

RUN git clone https://github.com/autowarefoundation/autoware.git --depth 1 /autoware \
    && mkdir /autoware/src \
    && vcs import --shallow /autoware/src < /autoware/autoware.repos \
    && . /opt/ros/humble/setup.sh \
    && colcon build \
      --base-paths /autoware/src \
      --build-base /autoware/build \
      --install-base /opt/autoware/humble/ \
      --cmake-args \
        " -Wno-dev" \
        " --no-warn-unused-cli" \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
        -DCMAKE_C_COMPILER_LAUNCHER=ccache \
        -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
    && rm -rf /autoware

FROM ubuntu:22.04
COPY --from=prebuilt /opt/autoware/humble /opt/autoware/humble
