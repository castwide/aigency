FROM alpine:latest

RUN apk update && apk upgrade && apk add --no-cache \
      build-base \
      musl-dev \
      linux-headers \
      openssh \
      netcat-openbsd \
      git \
      curl

RUN adduser -D -h /sandbox user
USER user

CMD ["sleep", "infinity"]
