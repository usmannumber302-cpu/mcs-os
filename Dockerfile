FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    live-build \
    sudo \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build
COPY config /build/config

# We must initialize lb config first to build the base layout, 
# then copy our config over it so our config is preserved.
# But actually, lb config can be run before COPY.
RUN lb config --architecture amd64 \
    --distribution bookworm \
    --archive-areas "main contrib non-free non-free-firmware" \
    --iso-application "Minecraft Server OS" \
    --iso-publisher "MCS OS" \
    --iso-volume "MCS_OS"

CMD ["lb", "build"]
