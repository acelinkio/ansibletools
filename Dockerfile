FROM ubuntu:20.04

COPY requirements.txt ./

RUN apt-get -qqy update \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy --no-install-recommends install \
    python3 \
    python3-pip \
    git \
    curl \
    wget \
    unzip \
    nano \
    openssh-client \
    sshpass \
    rsync \
    telnet \
    dnsutils \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

RUN \
    # install terraform
    wget https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_linux_amd64.zip \
    && unzip terraform_1.0.11_linux_amd64.zip -d /bin/ \
    && rm terraform_1.0.11_linux_amd64.zip \
    # install helm
    ## https://helm.sh/docs/topics/version_skew/
    && wget https://get.helm.sh/helm-v3.7.1-linux-amd64.tar.gz \
    && tar -xf helm-v3.7.1-linux-amd64.tar.gz linux-amd64/helm \
    && mv linux-amd64/helm /bin/ \
    && rm -rf linux-amd64 helm-v3.7.1-linux-amd64.tar.gz

CMD ["sh"]