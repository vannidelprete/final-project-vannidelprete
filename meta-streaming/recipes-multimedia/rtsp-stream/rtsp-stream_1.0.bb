SUMMARY = "Minimal RTSP server that streams the vivid V4L2 device over RTSP"
DESCRIPTION = "C++ application using gst-rtsp-server to expose /dev/video0 \
  at rtsp://0.0.0.0:8554/stream (issue #13)."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

DEPENDS = "gstreamer1.0 gstreamer1.0-rtsp-server"

SRC_URI = " \
    file://rtsp-stream.cpp \
    file://Makefile \
"

S = "${WORKDIR}"

inherit pkgconfig

do_compile() {
    oe_runmake -C ${WORKDIR}
}

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/rtsp-stream ${D}${bindir}/rtsp-stream
}

FILES:${PN} = "${bindir}/rtsp-stream"

