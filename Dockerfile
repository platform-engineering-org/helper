FROM registry.access.redhat.com/ubi9:9.1.0-1750

RUN dnf install -y \
    unzip-6.0-56.el9.x86_64 \
    wget-1.21.1-7.el9.x86_64 \
    dnf-plugins-core-4.1.0-3.el9.noarch \
    make-1:4.3-7.el9.x86_64 && \
    dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo && \
    dnf install -y terraform-1.3.7-1.x86_64 && \
    dnf clean all -y && \
    wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.43.0/terragrunt_linux_amd64 -O /usr/local/bin/terragrunt && \
    chmod +x /usr/local/bin/terragrunt && \
    wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip && \
    unzip awscli-exe-linux-x86_64.zip && \
    ./aws/install

WORKDIR /repo
