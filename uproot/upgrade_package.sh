#!/bin/bash

BASE_IMAGE="continuumio/miniconda3:24.5.0-0"

docker pull "${BASE_IMAGE}"
docker run \
	--rm \
	-ti \
	--user 1000:1000 \
	--volume $PWD:/workdir \
	--workdir /workdir \
	"${BASE_IMAGE}" \
	bash -c "python -m venv .venv && \
		. .venv/bin/activate && \
		python -m pip --no-cache-dir install --upgrade uv && \
		uv pip compile --no-cache --generate-hashes --output-file=requirements.lock --upgrade-package '${1}' requirements.txt && \
		deactivate && \
		rm -rf .venv"
