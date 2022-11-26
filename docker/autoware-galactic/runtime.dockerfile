#
# docker build -t ghcr.io/bouncmpe/autoware:galactic-runtime
#
FROM amd64/ros:galactic-ros-base

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
    sudo \
    git \
    tar curl wget zip unzip gnupg2 \
    python3-pip \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* 

RUN groupadd work -g 1000 \
   && useradd -ms /bin/bash autoware -g 1000 -u 1000 \
   && printf "autoware:autoware" | chpasswd \
   && printf "autoware ALL= NOPASSWD: ALL\\n" >> /etc/sudoers

USER autoware
WORKDIR /home/autoware

RUN python3 -m pip install --user ansible
ENV PATH=$HOME/.local/bin:$PATH

RUN ansible-galaxy collection install git+https://github.com/boundrivesim/autoware-istanbul.git#/ansible/,main 
RUN ansible-playbook bouncmpe.autoware.runtime