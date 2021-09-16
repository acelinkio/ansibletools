FROM ubuntu:20.04

COPY requirements.txt ./

# install core packages
RUN apt-get -qqy update \
    && apt-get -qqy --no-install-recommends install \
    python3 \
    python3-pip \
    git \
    curl \
    nano \
    openssh-client \
    sshpass \
    rsync \
    telnet \
    dnsutils \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# install ansible using temporary virtual packages
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

RUN \
    # install terraform
    wget https://releases.hashicorp.com/terraform/1.0.6/terraform_1.0.6_linux_amd64.zip \
    && unzip terraform_1.0.6_linux_amd64.zip -d /bin/ \
    && rm terraform_1.0.6_linux_amd64.zip \
    # install kubectl
    && wget https://dl.k8s.io/release/v1.22.1/bin/linux/amd64/kubectl \
    && chmod +x kubectl \
    && mv kubectl /bin/ \
    # install helm
    && wget https://get.helm.sh/helm-v3.6.3-linux-amd64.tar.gz \
    && tar -xf helm-v3.6.3-linux-amd64.tar.gz linux-amd64/helm \
    && mv linux-amd64/helm /bin/ \
    && rm -rf linux-amd64 helm-v3.6.3-linux-amd64.tar.gz

CMD ["sh"]