#include <gst/gst.h>
#include <gst/rtsp-server/rtsp-server.h>
#include <iostream>

int main(int argc, char *argv[])
{
    const char *device = (argc > 1) ? argv[1]   : "/dev/video0";
    const char *port = (argc > 2) ? argv[2]     : "8554";
    const char *mount = (argc > 3) ? argv[3]    : "/stream";

    gst_init(&argc, &argv);

    GMainLoop *loop = g_main_loop_new(nullptr, FALSE);

    GstRTSPServer *server = gst_rtsp_server_new();
    gst_rtsp_server_set_address(server, "0.0.0.0");
    gst_rtsp_server_set_service(server, port);

    GstRTSPMountPoints *mounts = gst_rtsp_server_get_mount_points(server);

    gchar *pipeline = g_strdup_printf("( v4l2src device=%s ! videoconvert ! x264enc tune=zerolatency ! "
          "rtph264pay name=pay0 pt=96 )", device);

    GstRTSPMediaFactory *factory = gst_rtsp_media_factory_new();
    gst_rtsp_media_factory_set_launch(factory, pipeline);
    gst_rtsp_media_factory_set_shared(factory, TRUE);
    g_free(pipeline);

    gst_rtsp_mount_points_add_factory(mounts, mount, factory);
    g_object_unref(mounts);

    gst_rtsp_server_attach(server, nullptr);

    std::cout << "RTSP server listening at rtsp://0.0.0.0:"
        << port << mount << std::endl;

    g_main_loop_run(loop);

    g_object_unref(server);
    g_main_loop_unref(loop);

    return 0;
}
