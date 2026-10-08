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
    #   ruby \
    #   ruby-dev \
    #   ruby-bundler \
    #   yaml-dev
RUN adduser -D -h /homedir user
USER app
CMD ["sleep", "infinity"]
