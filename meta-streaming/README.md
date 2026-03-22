# meta-streaming

Custom Yocto layer for the streaming project. Contains recipes for GStreamer packages and the streaming application.

## Compatibility

- Yocto release: **Scarthgap (5.0)**
- Target machine: **qemuarm64**

## Layer structure

```
meta-streaming/
├── conf/
│   └── layer.conf          # Layer configuration
└── recipes-kernel/
    └── linux/
        ├── linux-yocto_%.bbappend      # Kernel recipe extension
        └── linux-yocto/
            └── vivid.cfg               # Kernel config fragment (CONFIG_VIDEO_VIVID=m)
```

## Usage

The layer is already registered in `build/conf/bblayers.conf`. No additional setup required.
