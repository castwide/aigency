FROM alpine:latest

RUN apk add --no-cache \
      build-base \
      musl-dev \
      linux-headers \
      openssh \
      git \
      curl

RUN adduser -D -h /sandbox user
USER user

CMD ["sleep", "infinity"]
