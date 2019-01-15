FROM golang:1.11-alpine3.7

ARG CLOUD_SDK_VERSION=219.0.1
ENV CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION

WORKDIR "/"
ENV PATH /google-cloud-sdk/bin:$PATH

RUN apk --no-cache add \
        jq \
        curl \
        python \
        py-crcmod \
        bash \
        libc6-compat \
        openssh-client \
        alpine-sdk \
        git \
        gnupg \
    && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf ./google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    ln -s /lib /lib64 && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud --version

VOLUME ["/root/.config"]

RUN go get -u github.com/rancher/trash

RUN echo '[http]\n\
sslverify = false\n'\
> $HOME/.gitconfig

