FROM alpine:latest

# Use tini (https://github.com/krallin/tini) for proper signal handling.
RUN apk add --no-cache tini
ENTRYPOINT ["/sbin/tini", "--"]

ADD ./target/x86_64-unknown-linux-musl/release/syntect_server /
EXPOSE 9238
ENV ROCKET_ENV "production"
ENV ROCKET_PORT 9238

RUN addgroup -S sourcegraph && adduser -S -G sourcegraph -h /home/sourcegraph sourcegraph
USER sourcegraph

CMD ["/syntect_server"]
