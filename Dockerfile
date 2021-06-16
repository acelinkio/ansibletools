FROM python:3.9.5-alpine3.13

COPY requirements.txt ./

# install core packages
RUN apk add --update --no-cache \
    # common
    git \
    curl \
    nano \
    openssh-client \
    sshpass \
    rsync \
    # telnet
    busybox-extras \
    # dig nsloop 
    bind-tools \
    # required for cyptography
    ## https://cryptography.io/en/latest/installation/#alpine
    musl-dev \
    libffi-dev \
    openssl-dev \
    cargo

# install ansible using temporary virtual packages
RUN apk add --update --no-cache \
    --virtual .build-deps \
        make \
        gcc \
        python3-dev \
    && pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt \
    && apk del --no-network .build-deps

RUN \
    # install terraform
    wget https://releases.hashicorp.com/terraform/1.0.0/terraform_1.0.0_linux_amd64.zip \
    && unzip terraform_1.0.0_linux_amd64.zip -d /bin/ \
    && rm terraform_1.0.0_linux_amd64.zip \
    # install kubectl
    && wget https://dl.k8s.io/release/v1.21.1/bin/linux/amd64/kubectl \
    && chmod +x kubectl \
    && mv kubectl /bin/ \
    # install helm
    && wget https://get.helm.sh/helm-v3.5.4-linux-amd64.tar.gz \
    && tar -xf helm-v3.5.4-linux-amd64.tar.gz linux-amd64/helm \
    && mv linux-amd64/helm /bin/ \
    && rm -rf linux-amd64 helm-v3.5.4-linux-amd64.tar.gz

CMD ["sh"]