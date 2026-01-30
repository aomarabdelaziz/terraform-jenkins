FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    curl unzip git bash ca-certificates

# Terraform
RUN curl -fsSL https://releases.hashicorp.com/terraform/1.6.3/terraform_1.6.3_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform.zip

# AWS CLI
RUN curl -fsSL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf aws awscliv2.zip

# kubectl
RUN curl -fsSL -o /usr/local/bin/kubectl https://dl.k8s.io/release/v1.30.0/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl

# helm
RUN curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

USER root
