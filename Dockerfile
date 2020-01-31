FROM arm32v7/python:3.8-slim-buster

RUN apt-get update \
  && apt-get install -y git cmake remake gcc g++ pkg-config \
  && git clone --depth=1 --branch=OpenSSL_1_1_1d https://github.com/openssl/openssl.git \
  && cd openssl && chmod +x config && ./config && remake -j4 && remake -j1 install \
  && pip install --upgrade pip \
  && pip install git+https://github.com/awslabs/aws-crt-python@v0.5.8 \
  && pip install awsiotsdk \
  && apt-get remove -y cmake git remake gcc g++ pkg-config \
  && rm -rf openssl \
  && rm -rf /var/lib/apt/lists/*
