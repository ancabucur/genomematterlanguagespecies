FROM ubuntu:16.04

MAINTAINER Anca Bucur <anca.m.bucur@gmail.com>

#ENV HTTP_PROXY "http://www-proxy-ams.nl.oracle.com:80"
#ENV FTP_PROXY "http://www-proxy-ams.nl.oracle.com:80"
#ENV http_proxy $HTTP_PROXY
#ENV https_proxy $HTTP_PROXY
#ENV HTTPS_PROXY $HTTP_PROXY
#ENV ftp_proxy $FTP_PROXY
#ENV no_proxy=localhost,.alm.oraclecorp.com,alm.oraclecorp.com,.oraclecorp.com,us.oracle.com,.oraclecloud.com,127.0.0.1,10.245.2.154,10.245.2.155
#ENV NO_PROXY=$no_proxy


USER root

WORKDIR /home/root


RUN apt-get update 
RUN apt-get install -y software-properties-common build-essential wget ant default-jre default-jdk autoconf autopoint bison flex gettext libasound2-dev libglib2.0-dev libpulse-dev libtool xorg openbox

RUN apt-add-repository -y ppa:git-core/ppa
RUN apt-get update
RUN apt-get -y install git



RUN git clone -b 1.12.0 --recurse-submodules git://anongit.freedesktop.org/gstreamer/gstreamer
WORKDIR /home/root/gstreamer
RUN git submodule update
RUN ./autogen.sh --disable-debug --disable-gtk-doc
RUN make -j$(nproc)
RUN make install
WORKDIR /home/root/


RUN git clone -b 1.12.0 --recursive git://anongit.freedesktop.org/gstreamer/gst-plugins-base
WORKDIR /home/root/gst-plugins-base
RUN git submodule update
RUN ./autogen.sh --disable-debug --disable-gtk-doc
RUN make -j$(nproc)
RUN make install
WORKDIR /home/root/

RUN git clone --recursive git://anongit.freedesktop.org/gstreamer/gst-plugins-good
WORKDIR /home/root/gst-plugins-good
RUN git checkout tags/1.12.0
RUN git submodule update
RUN ./autogen.sh --disable-debug --disable-gtk-doc --disable-libpng --disable-oss --disable-oss4
RUN make -j$(nproc)
RUN make install
WORKDIR /home/root/

RUN git clone --recursive git://anongit.freedesktop.org/gstreamer/gst-plugins-bad
WORKDIR /home/root/gst-plugins-bad
RUN git checkout tags/1.12.0
RUN git submodule update
RUN ./autogen.sh --disable-debug --disable-decklink --disable-dvb --disable-fbdev --disable-gtk-doc --disable-x11 --disable-opengl --disable-glx --enable-gles2 --disable-vcd --disable-wayland --with-gles2-module-name=/opt/vc/lib/libGLESv2.so --with-egl-module-name=/opt/vc/lib/libEGL.so
RUN make -j$(nproc)
RUN make install
WORKDIR /home/root/

RUN git clone https://github.com/FFmpeg/gas-preprocessor.git
WORKDIR /home/root/gas-preprocessor
RUN chmod a+x gas-preprocessor.pl
RUN cp gas-preprocessor.pl /usr/local/bin
WORKDIR /home/root/

RUN git clone --recursive git://anongit.freedesktop.org/gstreamer/gst-libav
WORKDIR /home/root/gst-libav
RUN git checkout tags/1.12.0
RUN git submodule update
RUN AS=gcc ./autogen.sh --disable-debug --disable-gtk-doc
RUN make -j$(nproc)
RUN make install
WORKDIR /home/root/

RUN git clone https://github.com/GStreamer/gstreamer-vaapi.git
WORKDIR /home/root/gstreamer-vaapi
RUN git checkout tags/1.12.0
RUN git submodule update
RUN ./autogen.sh --disable-debug --disable-gtk-doc
RUN make -j$(nproc)
RUN make install
WORKDIR /home/root/

RUN wget https://github.com/processing/processing/releases/download/processing-0263-3.3.6/processing-3.3.6-linux64.tgz
RUN tar -xvf processing-3.3.6-linux64.tgz
RUN mkdir processing-3.3.6/sketchbook
RUN echo "sketchbook.path=/home/root/processing-3.3.6/sketchbook" > /home/root/.processing/preferences.txt

RUN git clone https://github.com/senisioi/processing-glvideo.git
RUN cd processing-glvideo/src/native/ && make clean && make

RUN cd processing-glvideo/ && \rm glvideo.zip && ant clean && ant && ant dist
RUN mv processing-glvideo/glvideo.zip processing-3.3.6/sketchbook/libraries
RUN cd processing-3.3.6/sketchbook/libraries && unzip glvideo.zip

WORKDIR /home/root/processing-3.3.6/sketchbook/libraries
RUN git clone https://github.com/ddf/Minim minim

#RUN git clone https://github.com/sojamo/controlp5.git
RUN wget https://github.com/sojamo/controlp5/releases/download/v2.2.6/controlP5-2.2.6.zip
RUN unzip controlP5-2.2.6.zip

RUN wget https://github.com/wblut/HE_Mesh/releases/download/5.0.3/hemesh20170306.zip
RUN unzip hemesh20170306.zip

WORKDIR /home/root/processing-3.3.6
CMD ./processing
