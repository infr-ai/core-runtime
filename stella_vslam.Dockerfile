FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y build-essential software-properties-common wget curl unzip git cmake ninja-build clang-format \
    libgl1-mesa-dev libwayland-dev libxkbcommon-dev wayland-protocols libegl1-mesa-dev \
    libglew-dev libeigen3-dev \
    libjpeg-dev libpng-dev \
    libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libavdevice-dev \
    libssl-dev libopencv-dev libboost-dev libboost-serialization-dev \
    libspdlog-dev libboost-date-time-dev libboost-log-dev libyaml-cpp-dev libsuitesparse-dev \
    libcgal-dev qtbase5-dev qtbase5-dev-tools qt6-base-dev qt6-base-dev-tools \
    libsqlite3-dev libgflags-dev libglew-dev libpango1.0-dev

WORKDIR /app

# Pangolin
RUN cd /app && git clone https://github.com/stevenlovegrove/Pangolin.git && cd Pangolin && git checkout 7364b59 && \
    mkdir -p build && cd build && cmake .. && make -j && make install && cd /app

# g2o
RUN cd /app && git clone --recursive https://github.com/RainerKuemmerle/g2o.git && cd g2o && git checkout e8df200 && \
    mkdir -p build && cd build && cmake .. && make -j && make install && cd /app
    
# FBoW
RUN cd /app && git clone --recursive https://github.com/stella-cv/FBoW.git && cd FBoW && \
    mkdir -p build && cd build && cmake .. && make -j && make install && cd /app

# stella_vslam
RUN cd /app && git clone --recursive https://github.com/stella-cv/stella_vslam.git && cd stella_vslam && git checkout a18add7 && \
    mkdir -p build && cd build && cmake .. && make -j && make install && cd /app

RUN wget https://github.com/stella-cv/FBoW_orb_vocab/raw/main/orb_vocab.fbow -O /app/orb_vocab.fbow
