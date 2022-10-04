ARG platform="linux/amd64"
FROM --platform=${platform} python:3.9-slim

RUN export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get dist-upgrade -y && \
  rm -rf /var/lib/apt/lists/*
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

COPY ./generator.py /generator.py
ENTRYPOINT ["python", "/generator.py"]
