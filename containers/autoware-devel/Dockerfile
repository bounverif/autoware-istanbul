FROM ghcr.io/bounverif/autoware-build:latest

RUN git clone https://github.com/tier4/scenario_simulator_v2 --depth 1 /scenario_simulator_v2 \
    && mkdir /scenario_simulator_v2/src \
    && vcs import --shallow /scenario_simulator_v2/src < /scenario_simulator_v2/dependency_humble.repos \
    && . /opt/ros/humble/setup.sh \
    && colcon build \
      --base-paths /scenario_simulator_v2/src \
      --build-base /scenario_simulator_v2/build \
      --install-base /opt/scenario_simulator_v2/humble/ \
      --cmake-args \
        " -Wno-dev" \
        " --no-warn-unused-cli" \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
        -DCMAKE_C_COMPILER_LAUNCHER=ccache \
        -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
    && rm -rf /scenario_simulator_v2
