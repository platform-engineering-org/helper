FROM registry.access.redhat.com/ubi9:9.2-489@sha256:8614ce95268b970880a1eca97dddfce5154fab35418d839c5f75012cccaca0d9

COPY requirements.txt .tool-versions /root/

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
