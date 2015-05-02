
# Pull base image.
FROM ubuntu:latest

RUN \
  apt-get update -qq && apt-get upgrade -qq
# Install apps.
RUN \
  apt-get install -y git mercurial wget \
    tar gzip bzip2 xz-utils \
    gcc g++ cmake libtool autoconf yasm nasm pkg-config
RUN \
  cd /tmp && \
  git clone https://github.com/georgmartius/vid.stab.git && \
  cd vid.stab && \
  cmake . && \
  make && make install
RUN \
  cd /tmp && \
  git clone https://github.com/mstorsjo/fdk-aac.git && \
  cd fdk-aac && \
  ./autogen.sh && \
  ./configure && \
  make && make install
# RUN \
#  cd /tmp && \
#  wget http://downloads.sourceforge.net/faac/faac-1.28.tar.bz2 && \
#  tar xvf faac-1.28.tar.bz2 && \
#  cd faac-1.28 && \
#  ./configure && \
#  make && make install
RUN \
  cd /tmp && \
  git clone git://git.videolan.org/x264.git && \
  cd x264 && \
  ./configure --enable-shared && \
  make && make install
RUN \
  cd /tmp && \
  hg clone https://bitbucket.org/multicoreware/x265 && \
#  cd x265/build/linux && ./make-Makefiles.bash && \
  cd x265 && \
  cmake -G "Unix Makefiles" ./source && \
  make && make install
RUN \
  cd /tmp && \
  wget http://downloads.xiph.org/releases/opus/opus-1.1.tar.gz && \
  tar xvzf opus-1.1.tar.gz && \
  cd opus-1.1 && \
  ./configure && \
  make && make install
RUN \
  cd /tmp && \
  wget http://downloads.sourceforge.net/project/soxr/soxr-0.1.1-Source.tar.xz && \
  tar Jxvf soxr-0.1.1-Source.tar.xz && \
  cd soxr-0.1.1-Source && \
  cmake . && \
  make && make install
RUN \
  cd /tmp && \
  wget http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.xz && \
  tar Jxvf libogg-1.3.2.tar.xz && \
  cd libogg-1.3.2 && \
  ./configure && \
  make && make install
RUN \
  cd /tmp && \
  wget http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.5.tar.xz && \
  tar Jxvf libvorbis-1.3.5.tar.xz && \
  cd libvorbis-1.3.5 && \
  ./configure && \
  make && make install
RUN \
  apt-get install libjpeg-dev libgif-dev libtiff5-dev libpng12-dev -y && \
  cd /tmp && \
  wget http://downloads.webmproject.org/releases/webp/libwebp-0.4.3.tar.gz && \
  tar xvzf libwebp-0.4.3.tar.gz && \
  cd libwebp-0.4.3 && \
  ./configure && \
  make && make install
RUN \
  cd /tmp && \
  git clone https://chromium.googlesource.com/webm/libvpx && \
  cd libvpx && \
  ./configure --enable-shared && \
  make && make install
RUN \
  apt-get install -y libmp3lame-dev libbz2-dev && \
  cd /tmp && \
  ldconfig && \
  wget http://www.ffmpeg.org/releases/ffmpeg-2.6.2.tar.bz2 && \
  tar jxvf ffmpeg-2.6.2.tar.bz2 && \
  cd /tmp/ffmpeg-2.6.2 && \
  ./configure --enable-gpl --enable-version3 --enable-nonfree --enable-libsoxr --enable-libvidstab --enable-libmp3lame --enable-libfdk-aac --enable-libopus --enable-libvorbis --enable-libwebp --enable-libvpx --enable-libx264 --enable-libx265 && \
  make && make install

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data
