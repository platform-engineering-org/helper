FROM registry.access.redhat.com/ubi9:9.1.0-1750.1675784955

COPY requirements.txt .

RUN dnf install -y \
    git openssh-clients unzip wget dnf-plugins-core python3-pip make && \
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
