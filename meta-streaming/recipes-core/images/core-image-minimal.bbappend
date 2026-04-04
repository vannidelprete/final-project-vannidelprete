IMAGE_INSTALL:append = " kernel-modules"

# Issue #8: RTSP server library for streaming pipeline
IMAGE_INSTALL:append = " gstreamer1.0-rtsp-server"
