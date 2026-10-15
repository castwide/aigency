FROM alpine:latest

RUN apk update && apk upgrade && apk add --no-cache \
      autoconf \
      bash \
      bison \
      build-base \
      curl \
      git \
      libffi-dev \
      linux-headers \
      mise \
      musl-dev \
      netcat-openbsd \
      nodejs \
      openssh \
      openssl \
      openssl-dev \
      perl \
      pkgconf \
      python3 \
      tzdata \
      xz \
      yaml-dev \
      zlib-dev

RUN adduser -D -h /sandbox user \
    && mkdir -p /opt/mise \
    && chown -R user:user /opt/mise
USER user
ENV MISE_DATA_DIR=/opt/mise \
    MISE_CONFIG_DIR=/opt/mise/config \
    MISE_TRUSTED_CONFIG_PATHS=/sandbox \
    PATH=/opt/mise/shims:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN mise use -g ruby@3.4 && mise install --yes

CMD ["sleep", "infinity"]
