
# Pull base image.
FROM dockerfile/ubuntu

# Install apps.
RUN \
  apt-get update && apt-get upgrade -y && \
  apt-get install mercurial cmake libtool autoconf yasm nasm pkg-config libmp3lame-dev libbz2-dev -y
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
  wget http://sourceforge.net/projects/soxr/files/soxr-0.1.1-Source.tar.xz && \
  tar xvf soxr-0.1.1-Source.tar.xz && \
  cd soxr-0.1.1-Source && \
  cmake . && \
  make && make install
RUN \
  apt-get install libjpeg-dev libgif-dev libtiff5-dev libpng12-dev -y && \
  cd /tmp && \
  wget https://webp.googlecode.com/files/libwebp-0.4.0.tar.gz && \
  tar xvzf libwebp-0.4.0.tar.gz && \
  cd libwebp-0.4.0 && \
  ./configure && \
  make && make install
RUN \
  cd /tmp && \
  git clone https://chromium.googlesource.com/webm/libvpx && \
  cd libvpx && \
  ./configure --enable-shared && \
  make && make install
RUN \
  cd /tmp && \
  ldconfig && \
  wget http://www.ffmpeg.org/releases/ffmpeg-2.2.3.tar.gz && \
  tar xvzf ffmpeg-2.2.3.tar.gz && \
  cd /tmp/ffmpeg-2.2.3 && \
  ./configure --enable-gpl --enable-version3 --enable-nonfree --enable-libsoxr --enable-libvidstab --enable-libmp3lame --enable-libfdk-aac --enable-libopus --enable-libwebp --enable-libvpx --enable-libx264 --enable-libx265 && \
  make && make install

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data
