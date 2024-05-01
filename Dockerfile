FROM alpine:3.19

# install typst
RUN wget https://github.com/typst/typst/releases/download/v0.11.0/typst-x86_64-unknown-linux-musl.tar.xz \
    && tar -xf typst-x86_64-unknown-linux-musl.tar.xz \
    && mv typst-x86_64-unknown-linux-musl/typst /usr/local/bin/

# install fswatch
RUN apk add build-base
RUN wget https://github.com/emcrisostomo/fswatch/releases/download/1.17.1/fswatch-1.17.1.tar.gz \
    && tar -xf fswatch-1.17.1.tar.gz \
    && cd fswatch-1.17.1 \
    && ./configure \
    && make \
    && make install

# install watch script
COPY watch.sh /bin/
RUN chmod +x /bin/watch.sh

WORKDIR /src
