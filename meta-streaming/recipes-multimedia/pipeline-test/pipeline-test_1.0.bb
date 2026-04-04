SUMMARY = "V4L2 to GStreamer pipeline verification script"
DESCRIPTION = "Installs verify-pipeline.sh to smoke-test the vivid V4L2 device \
and GStreamer pipeline inside QEMU (issue #9)."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://verify-pipeline.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/verify-pipeline.sh ${D}${bindir}/verify-pipeline.sh
}

FILES:${PN} = "${bindir}/verify-pipeline.sh"
