#
# Copyright 2010-2013 Bluecherry
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of
# the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#

include(cmake/FindGStreamer.cmake)
include(cmake/FindGLIB.cmake)

SET(GSTREAMER_COMPONENTS app)
SET(GLIB_COMPONENTS gobject)

FIND_PACKAGE(GStreamer 1.0.0 REQUIRED COMPONENTS ${GSTREAMER_COMPONENTS} REQUIRED)
FIND_PACKAGE(GLIB 2.31.8 REQUIRED COMPONENTS ${GLIB_COMPONENTS})

include_directories (${GSTREAMER_INCLUDE_DIRS})
include_directories (${GLIB_INCLUDE_DIRS})

list (APPEND bluecherry_client_LIBRARIES
    ${GSTREAMER_LIBRARIES}
    ${GLIB_LIBRARIES}
    ${GLIB_GOBJECT_LIBRARIES}
)

if (UNIX AND NOT APPLE)
    include_directories (${GSTREAMER_APP_INCLUDE_DIRS})

    list (APPEND bluecherry_client_LIBRARIES
        ${GSTREAMER_APP_LIBRARIES}
    )

    set (GSTREAMER_PLUGIN_PATHS "${GSTREAMER_PLUGIN_PATHS}")
    set (GSTREAMER_PLUGIN_PREFIX "lib")
    set (GSTREAMER_PLUGIN_SUFFIX ".so")
    set (GSTREAMER_PLUGINS "gsttypefindfunctions:gstapp:gstdecodebin:gstmatroska:gstffmpegcolorspace:gstcoreelements:gstffmpeg")

endif (UNIX AND NOT APPLE)

if (APPLE)
    set (GSTREAMER_PLUGIN_PATHS "./../PlugIns/gstreamer/:${GSTREAMER_PLUGIN_PATHS}")
    set (GSTREAMER_PLUGIN_PREFIX "lib")
    set (GSTREAMER_PLUGIN_SUFFIX ".so")
    set (GSTREAMER_PLUGINS "gsttypefindfunctions:gstapp:gstdecodebin2:gstmatroska:gstffmpegcolorspace:gstcoreelements:gstffmpeg:gstosxaudio:gstautodetect:gstaudioconvert:gstaudioresample:gstvolume")
endif (APPLE)

if (WIN32)
    if (CMAKE_BUILD_TYPE MATCHES Debug)
        set (GSTREAMER_PLUGIN_PATHS "${CMAKE_SOURCE_DIR}/gstreamer-bin/win/plugins:${GSTREAMER_PLUGIN_PATHS}")
    else (CMAKE_BUILD_TYPE MATCHES Debug)
        set (GSTREAMER_PLUGIN_PATHS "./plugins:${GSTREAMER_PLUGIN_PATHS}")
    endif (CMAKE_BUILD_TYPE MATCHES Debug)

    set (GSTREAMER_PLUGIN_PREFIX "lib")
    set (GSTREAMER_PLUGIN_SUFFIX ".dll")
    set (GSTREAMER_PLUGINS "gsttypefindfunctions:gstapp:gstdecodebin2:gstmatroska:gstffmpegcolorspace:gstcoreelements:gstffmpeg-lgpl:gstautodetect:gstaudioconvert:gstaudioresample:gstvolume:gstdirectsoundsink")
endif (WIN32)
