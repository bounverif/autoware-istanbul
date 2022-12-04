cgdevel:
	DOCKER_BUILDKIT=1 docker build . \
	--tag ghcr.io/bouncmpe/autoware:humble-devel \
	--file docker/autoware-humble/devel.dockerfile

cgruntime: cgdevel
	DOCKER_BUILDKIT=1 docker build . \
	--tag ghcr.io/bouncmpe/autoware:humble-runtime \
	--file docker/autoware-humble/runtime.dockerfile

install:
	ansible-galaxy install -r requirements.yml --force

build: install
	ansible-playbook bouncmpe.autoware.build

.PHONY: install build