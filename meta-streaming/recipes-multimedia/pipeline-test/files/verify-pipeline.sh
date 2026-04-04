#!/bin/sh
# verify-pipeline.sh — Smoke test for V4L2 → GStreamer pipeline (issue #9)

PASS=0
FAIL=1

check() {
    if [ $1 -eq 0 ]; then
        echo "[PASS] $2"
    else
        echo "[FAIL] $2"
        exit $FAIL
    fi
}

echo "=== V4L2 → GStreamer pipeline verification ==="

# Step 1: load vivid module
echo ""
echo "--- Step 1: loading vivid module ---"
modprobe vivid
check $? "modprobe vivid"

# Step 2: check /dev/video0 is present
echo ""
echo "--- Step 2: checking /dev/video0 ---"
[ -e /dev/video0 ]
check $? "/dev/video0 present"

# Step 3: basic pipeline with fakesink (5 seconds)
echo ""
echo "--- Step 3: v4l2src ! fakesink (5 s) ---"
timeout 5 gst-launch-1.0 -q v4l2src device=/dev/video0 num-buffers=30 ! fakesink sync=false
check $? "gst-launch-1.0 v4l2src ! fakesink"

# Step 4: pipeline with videoconvert (optional, graceful failure)
echo ""
echo "--- Step 4: v4l2src ! videoconvert ! fakesink (optional) ---"
timeout 5 gst-launch-1.0 -q v4l2src device=/dev/video0 num-buffers=30 ! videoconvert ! fakesink sync=false
if [ $? -eq 0 ]; then
    echo "[PASS] v4l2src ! videoconvert ! fakesink"
else
    echo "[SKIP] videoconvert step failed (non-fatal)"
fi

echo ""
echo "=== All required checks passed ==="
