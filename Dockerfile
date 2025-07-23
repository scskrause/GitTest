# syntax=docker/dockerfile:1.7.0

FROM python:3.12-slim AS python-base

ENV VIRTUAL_ENV /srv/venv
ENV PATH $VIRTUAL_ENV/bin:$PATH





FROM python-base AS venv

ENV PIP_CACHE_DIR /mnt/cache
ENV UV_CACHE_DIR /mnt/cache

RUN --mount=type=cache,target=/mnt/cache <<EOF
	set -e
	python3 -m venv "$VIRTUAL_ENV"
	python3 -m pip install uv
	apt-get update
	apt-get --yes --no-install-recommends install build-essential libpcre3-dev rsync
EOF

RUN --mount=type=cache,target=/mnt/cache uv pip install Flask





FROM python-base AS pytest

COPY --from=venv $VIRTUAL_ENV $VIRTUAL_ENV

RUN pip3 freeze

WORKDIR /app
COPY . /app
CMD ["python3", "main.py"]

