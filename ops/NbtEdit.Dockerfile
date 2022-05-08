FROM debian:buster-slim

RUN apt update \
    && apt install -y --no-install-recommends \
      git curl ca-certificates gcc libc-dev vim
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN . $HOME/.cargo/env \
    && rustup override set stable \
    && rustup update stable

RUN git clone https://github.com/C4K3/nbted.git /tmp/nbted/ \
    && cd /tmp/nbted \
    && export PATH="$HOME/.cargo/bin:$PATH" \
    && cargo build --release \
    && cp -v $PWD/target/release/nbted /usr/bin/

WORKDIR /
CMD /usr/bin/nbted

