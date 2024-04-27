FROM ubuntu:24.04

RUN apt-get update

RUN apt-get install -y wget xz-utils fswatch

RUN wget https://github.com/typst/typst/releases/download/v0.11.0/typst-x86_64-unknown-linux-musl.tar.xz

RUN tar -xvf typst-x86_64-unknown-linux-musl.tar.xz

RUN mv typst-x86_64-unknown-linux-musl/typst /usr/local/bin/

WORKDIR /src

# compile typst files then incrementally compile 
# use poll_monitor because it's more reliable than inotify with docker mounted volumes
CMD typst compile *.typ && fswatch -0 --monitor=poll_monitor *.typ | xargs -0 -n1 -I{} typst compile "{}"

