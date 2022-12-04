#
# docker build -t ghcr.io/bouncmpe/autoware:humble-runtime
#
FROM ghcr.io/bouncmpe/autoware:humble-devel as builder

RUN ansible-playbook bouncmpe.autoware.build

FROM amd64/ros:humble-ros-base

COPY --from=builder /opt/autoware/humble /opt/autoware/humble

RUN groupadd work -g 1000 \
   && useradd -ms /bin/bash autoware -g 1000 -u 1000 \
   && printf "autoware:autoware" | chpasswd \
   && printf "autoware ALL= NOPASSWD: ALL\\n" >> /etc/sudoers

USER autoware
WORKDIR /home/autoware

