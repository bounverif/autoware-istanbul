#
# docker build -t ghcr.io/bouncmpe/autoware:galactic-runtime
#
FROM ghcr.io/bouncmpe/autoware:galactic-devel as builder

RUN ansible-playbook bouncmpe.autoware.build

FROM amd64/ros:galactic-ros-base

COPY --from=builder /tmp/autoware/install /opt/autoware/galactic

RUN groupadd work -g 1000 \
   && useradd -ms /bin/bash autoware -g 1000 -u 1000 \
   && printf "autoware:autoware" | chpasswd \
   && printf "autoware ALL= NOPASSWD: ALL\\n" >> /etc/sudoers

USER autoware
WORKDIR /home/autoware

