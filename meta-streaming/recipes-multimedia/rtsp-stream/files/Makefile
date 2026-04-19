CXX ?= g++
CXXFLAGS += $(shell pkg-config --cflags gstreamer-1.0 gstreamer-rtsp-server-1.0)
LDFLAGS += $(shell pkg-config --libs gstreamer-1.0 gstreamer-rtsp-server-1.0)

all: rtsp-stream

rtsp-stream: rtsp-stream.cpp
	$(CXX) $(CXXFLAGS) $< -o $@ $(LDFLAGS)

clean:
	rm -f rtsp-stream

