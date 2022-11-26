cgdevel:
	DOCKER_BUILDKIT=1 docker build . \
	--tag ghcr.io/bouncmpe/autoware:galactic-devel \
	--file docker/autoware-galactic/devel.dockerfile

cgruntime:
	DOCKER_BUILDKIT=1 docker build . \
	--tag ghcr.io/bouncmpe/autoware:galactic-runtime \
	--file docker/autoware-galactic/runtime.dockerfile

install:
	ansible-galaxy install -r requirements.yml --force

build: install
	ansible-playbook bouncmpe.autoware.build

.PHONY: install build