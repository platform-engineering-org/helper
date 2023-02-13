FROM registry.access.redhat.com/ubi9:9.1.0-1750.1675784955

COPY requirements.txt .

RUN dnf install -y \
    git-2.31.1-2.el9.2.x86_64 \
    openssh-clients-8.7p1-24.el9_1.x86_64 \
    unzip-6.0-56.el9.x86_64 \
    wget-1.21.1-7.el9.x86_64 \
    dnf-plugins-core-4.1.0-3.el9.noarch \
    python3-pip-21.2.3-6.el9.noarch \
    make-1:4.3-7.el9.x86_64 && \
    dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo && \
    dnf install -y terraform-1.3.7-1.x86_64 && \
    dnf clean all -y && \
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.1 && \
    echo ". $HOME/.asdf/asdf.sh" >> ~/.bashrc && \
    echo ". $HOME/.asdf/completions/asdf.bash" >> ~/.bashrc && \
    wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.43.0/terragrunt_linux_amd64 -O /usr/local/bin/terragrunt && \
    chmod +x /usr/local/bin/terragrunt && \
    wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -O awscliv2.zip && \
    unzip awscliv2.zip && rm awscliv2.zip && \
    ./aws/install && \
    pip3 install -r requirements.txt

WORKDIR /workspace
