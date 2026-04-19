IMAGE_INSTALL:append = " kernel-modules"

# Issue #7: GStreamer core and plugins for V4L2 multimedia pipeline
IMAGE_INSTALL:append = " \
    gstreamer1.0 \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    "

# Issue #8: RTSP server library for streaming pipeline
IMAGE_INSTALL:append = " gstreamer1.0-rtsp-server"

# Issue #9: pipeline verification script
IMAGE_INSTALL:append = " pipeline-test"

# Issue #13: RTSP server application and x264 encoder plugin
IMAGE_INSTALL:append = " gstreamer1.0-plugins-ugly gstreamer1.0-plugins-ugly-x264 x264 rtsp-stream"
