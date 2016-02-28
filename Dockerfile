# Pull base image.
FROM debian:jessie

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
  git clone git://code.dyne.org/frei0r.git && \
  cd frei0r && \
  cmake . && \
  make && make install
RUN \
  cd /tmp && \
  git clone https://github.com/TimothyGu/libilbc.git && \
  cd libilbc && \
  cmake . && \
  make && make install && rm -rf *
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
  git clone https://github.com/cisco/openh264.git && \
  cd openh264 && \
  git checkout refs/tags/v1.5.0 && \
  make && make install
RUN \
  cd /tmp && \
  git clone https://github.com/ultravideo/kvazaar.git && \
  cd kvazaar && \
  ./autogen.sh && \
  ./configure && \
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
  wget http://downloads.sourceforge.net/project/soxr/soxr-0.1.2-Source.tar.xz && \
  tar Jxvf soxr-0.1.2-Source.tar.xz && \
  cd soxr-0.1.2-Source && \
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
  wget http://downloads.webmproject.org/releases/webp/libwebp-0.5.0.tar.gz && \
  tar xvzf libwebp-0.5.0.tar.gz && \
  cd libwebp-0.5.0 && \
  ./configure && \
  make && make install
RUN \
  apt-get install -y libva-dev && \
  cd /tmp && \
  git clone https://github.com/lu-zero/mfx_dispatch.git && \
  cd mfx_dispatch && \
  libtoolize && aclocal && autoconf && automake --add-missing && \
  ./configure --enable-shared && \
  make && make install
RUN \
  cd /tmp && \
  git clone https://chromium.googlesource.com/webm/libvpx && \
  cd libvpx && \
  ./configure --enable-shared && \
  make && make install
RUN \
  cd /tmp && \
  git clone https://github.com/foo86/dcadec.git && \
  cd dcadec && \
  make && make install
RUN \
  apt-get install -y libmp3lame-dev libbz2-dev libass-dev libbluray-dev libbs2b-dev libcaca-dev libgme-dev libgsm1-dev libopencore-amrnb-dev libopencore-amrwb-dev libopenjpeg-dev librtmp-dev libschroedinger-dev libspeex-dev libtheora-dev libtwolame-dev libvo-aacenc-dev libvo-amrwbenc-dev libwavpack-dev libpulse-dev && \
  ldconfig
RUN \
  cd /tmp && \
  git clone https://github.com/FFmpeg/FFmpeg.git
RUN \
  cd /tmp/FFmpeg && \
  git checkout refs/tags/n3.0 && \
  ./configure \
    --enable-gpl \
    --enable-version3 \
    --enable-nonfree \
    --enable-avisynth \
    --enable-bzlib \
    --enable-fontconfig \
    --enable-frei0r \
    --enable-gnutls \
    --enable-iconv \
    --enable-libass \
    --enable-libbluray \
    --enable-libbs2b \
    --enable-libcaca \
    --enable-libdcadec \
    --enable-libfdk-aac \
    --enable-libfreetype \
    --enable-libfribidi \
    --enable-libgme \
    --enable-libgsm \
    --enable-libilbc \
    --enable-libkvazaar \
    --enable-libmfx \
    --enable-libmp3lame \
    --enable-libopencore-amrnb \
    --enable-libopencore-amrwb \
    --enable-libopenh264 \
    --enable-libopenjpeg \
    --enable-libopus \
    --enable-librtmp \
    --enable-libschroedinger \
    --enable-libsoxr \
    --enable-libspeex \
    --enable-libtheora \
    --enable-libtwolame \
    --enable-libvidstab \
    --enable-libvo-aacenc \
    --enable-libvo-amrwbenc \
    --enable-libvorbis \
    --enable-libpulse \
    --enable-libvpx \
    --enable-libwavpack \
    --enable-libwebp \
    --enable-libx264 \
    --enable-libx265 \
    --enable-lzma \
    --enable-zlib && \
  make && make install

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data
