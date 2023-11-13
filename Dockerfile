FROM registry.access.redhat.com/ubi9:9.3-1361@sha256:7c2787c65620195e5c7184a7a28c1aca360152dd9d7ec7403d69f2b9dcc2ede1

COPY requirements.txt .tool-versions /root/

# renovate:  datasource=github-releases depName=asdf-vm/asdf
ENV ASDF_VERSION=v0.12.0

RUN dnf install -y \
    git openssh-clients python3-pip make unzip rubygems openssl-devel perl zlib-devel bzip2 && \
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
