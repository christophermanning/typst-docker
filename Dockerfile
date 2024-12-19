FROM alpine:3.19

# install typst
RUN wget https://github.com/typst/typst/releases/download/v0.12.0/typst-x86_64-unknown-linux-musl.tar.xz \
    && tar -xf typst-x86_64-unknown-linux-musl.tar.xz \
    && mv typst-x86_64-unknown-linux-musl/typst /usr/local/bin/

# install fswatch
RUN apk --no-cache add build-base
RUN wget https://github.com/emcrisostomo/fswatch/releases/download/1.17.1/fswatch-1.17.1.tar.gz \
    && tar -xf fswatch-1.17.1.tar.gz \
    && cd fswatch-1.17.1 \
    && ./configure \
    && make \
    && make install

# for compressing example images
RUN apk --no-cache add imagemagick

# install watch script
COPY watch.sh /usr/local/bin
RUN chmod +x /usr/local/bin/watch.sh

# install additional fonts
RUN apk --no-cache add fontconfig
# https://wiki.alpinelinux.org/wiki/Fonts#List_of_fonts_in_Alpine_Linux
RUN apk --no-cache add font-opensans
RUN fc-cache -f

WORKDIR /src
