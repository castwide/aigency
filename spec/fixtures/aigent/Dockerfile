FROM alpine:latest

# Alpine's libc is musl. "libc + dev tools" = build-base, which bundles
# gcc, g++, make, musl-dev (the libc headers) and binutils.
# (Listing musl-dev explicitly is redundant but makes the intent obvious.)
RUN apk add --no-cache \
      build-base \
      musl-dev \
      linux-headers \
      git \
      # Ruby toolchain for this project (psych/yaml need yaml-dev):
      ruby \
      ruby-dev \
      ruby-bundler \
      yaml-dev

# Create a non-root user/group with a stable uid/gid and switch to it.
RUN addgroup -g 1000 app && \
    adduser  -u 1000 -G app -D -h /home/app app
USER app

CMD ["sleep", "infinity"]
