FROM registry.access.redhat.com/ubi9:9.1.0-1782

COPY requirements.txt .tool-versions /root/

ENV ASDF_VERSION=0.11.2

RUN dnf install -y \
    git openssh-clients python3-pip make unzip && \
    dnf clean all -y && \
    git clone https://github.com/asdf-vm/asdf.git /root/.asdf --branch v"${ASDF_VERSION}" --depth 1 && \
    . $HOME/.asdf/asdf.sh && \
    asdf plugin-add awscli && \
    asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git && \
    asdf plugin-add pulumi && \
    asdf plugin-add terragrunt && \
    asdf install && \
    pip3 install -r /root/requirements.txt && \
    ln -s /usr/bin/python3 /usr/bin/python

WORKDIR /workspace
