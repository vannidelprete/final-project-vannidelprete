# Final Project - Embedded Linux Video Streaming System

## Project Overview

See the [Project Overview](https://github.com/vannidelprete/final-project-vannidelprete/wiki/Project-Overview) wiki page for the full project description, goals, hardware platform, build system, and schedule.

## System Architecture

```
+-------------------+       +-------------------+       +-------------------+
|   vivid (kernel)  |       |    GStreamer       |       |   RTSP Client     |
|                   |       |                   |       |                   |
|  /dev/video0  --> | V4L2  | v4l2src           |       |  VLC / ffplay     |
|  (virtual V4L2    +------>+ videoconvert      +------>+                   |
|   test device)    |       | x264enc           | RTSP  |  host machine     |
|                   |       | rtph264pay        |       |                   |
+-------------------+       +-------------------+       +-------------------+
        QEMU (qemuarm64)            QEMU                     Host (x86)
```

The pipeline runs entirely inside QEMU. The RTSP stream is forwarded to the host via QEMU slirp port forwarding on port 8554.

## Build Instructions

### Prerequisites

- Yocto Scarthgap (5.0) build environment
- All layers configured in `build/conf/bblayers.conf`:
  - `meta`, `meta-poky`, `meta-yocto-bsp` (from poky)
  - `meta-oe`, `meta-python`, `meta-multimedia` (from meta-openembedded)
  - `meta-streaming` (this project)

### Build the image

```bash
source poky/oe-init-build-env build
bitbake core-image-base
```

## Running the Demo

### 1. Start QEMU

```bash
source poky/oe-init-build-env build
runqemu qemuarm64 nographic slirp
```

Port 8554 is automatically forwarded from host to guest via `QB_SLIRP_OPT` in `build/conf/local.conf`.

### 2. Inside QEMU — load the virtual V4L2 device

```bash
modprobe vivid
```

This registers `/dev/video0` as a virtual V4L2 capture device generating a test pattern.

### 3. Inside QEMU — start the RTSP server

```bash
rtsp-stream
```

Optional arguments (all have defaults):

```bash
rtsp-stream [device] [port] [mount]
# e.g.: rtsp-stream /dev/video0 8554 /stream
```

The server prints:
```
RTSP server listening at rtsp://0.0.0.0:8554/stream
```

### 4. From the host — connect with ffplay or VLC

```bash
ffplay rtsp://127.0.0.1:8554/stream
# or
vlc rtsp://127.0.0.1:8554/stream
```

You should see the vivid test pattern video stream.

## Layer Structure

```
meta-streaming/
├── conf/
│   └── layer.conf
├── recipes-core/
│   └── images/
│       └── core-image-base.bbappend      # IMAGE_INSTALL additions
├── recipes-kernel/
│   └── linux/
│       ├── linux-yocto_%.bbappend        # kernel config extension
│       └── linux-yocto/
│           └── vivid.cfg                 # CONFIG_VIDEO_VIVID=m
└── recipes-multimedia/
    ├── gstreamer/
    │   ├── gstreamer1.0-plugins-ugly_%.bbappend   # enable x264 PACKAGECONFIG
    │   └── gstreamer1.0-rtsp-server_%.bbappend    # track rtsp-server dependency
    ├── pipeline-test/
    │   ├── files/verify-pipeline.sh
    │   └── pipeline-test_1.0.bb
    └── rtsp-stream/
        ├── files/
        │   ├── rtsp-stream.cpp           # RTSP server application (C++)
        │   └── Makefile
        └── rtsp-stream_1.0.bb
```
