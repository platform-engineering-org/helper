FROM registry.access.redhat.com/ubi9/python-311:9.5-1743582312@sha256:1051b028c18b5531433e2138de447ca0417f21653c7f47045e5c954817acbbe8

USER root
WORKDIR /root

COPY requirements.txt .tool-versions ./

# renovate:  datasource=github-releases depName=asdf-vm/asdf
ENV ASDF_VERSION=v0.12.0

RUN dnf install -y \
    git openssh-clients make unzip rubygems openssl-devel perl zlib-devel bzip2 && \
    dnf clean all -y && \
    git clone https://github.com/asdf-vm/asdf.git /root/.asdf --branch "${ASDF_VERSION}" --depth 1 && \
    . /root/.asdf/asdf.sh && \
    asdf plugin-add awscli && \
    asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git && \
    asdf plugin-add pulumi && \
    asdf plugin-add terragrunt && \
    asdf install && \
    pip3 install -r /root/requirements.txt && \
    ln -s /usr/bin/python3 /usr/bin/python

WORKDIR /workspace
