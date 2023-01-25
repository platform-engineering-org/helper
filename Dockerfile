FROM registry.access.redhat.com/ubi9:9.1.0-1750

RUN dnf install -y dnf-plugins-core-4.1.0-3.el9.noarch make-1:4.3-7.el9.x86_64 && \
    dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo && \
    dnf install -y terraform-1.3.7-1.x86_64 && \
    curl https://github.com/gruntwork-io/terragrunt/releases/download/v0.43.0/terragrunt_linux_amd64 -o /usr/local/bin/terragrunt && \
    chmod +x /usr/local/bin/terragrunt && \
    dnf clean all -y
