IMAGE_INSTALL:append = " kernel-modules"

# Issue #7: GStreamer core and plugins for V4L2 multimedia pipeline
IMAGE_INSTALL:append = " \
    gstreamer1.0 \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    "
