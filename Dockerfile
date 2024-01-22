FROM nvidia/cuda:12.3.1-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y build-essential software-properties-common wget curl unzip git cmake ninja-build clang-format \
    libgl1-mesa-dev libwayland-dev libxkbcommon-dev wayland-protocols libegl1-mesa-dev \
    libglew-dev libeigen3-dev \
    libjpeg-dev libpng-dev libspdlog-dev libsqlite3-dev libyaml-cpp-dev \
    libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libavdevice-dev \
    libssl-dev libopencv-dev libboost-dev libboost-serialization-dev

WORKDIR /app

# Pangolin
RUN cd /app && git clone https://github.com/stevenlovegrove/Pangolin.git && cd Pangolin && git checkout 7364b59 && \
    mkdir -p build && cd build && cmake .. && make -j && make install && cd /app

# ORB_SLAM3
RUN cd /app && git clone --recursive https://github.com/infr-ai/ORB_SLAM3.git && cd ORB_SLAM3 && \
    ./build.sh && cd /app

RUN cp /app/ORB_SLAM3/Vocabulary/ORBvoc.txt /app/orb_vocab.txt

# Insta360 MediaSDK
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32 && \
    add-apt-repository -y "deb http://security.ubuntu.com/ubuntu xenial-security main" && \
    apt update && apt install -y libjasper1 libjasper-dev
RUN wget https://file.insta360.com/static/07814586d4c390c59ffaab8b90d09659/LinuxSDK20231211.zip -O /tmp/SDK.zip && \
    unzip /tmp/SDK.zip -d /tmp/SDK && \
    unzip /tmp/SDK/LinuxSDK20231211/libMediaSDK-dev_2.0-0_ubuntu18.04_amd64.zip -d /tmp/MediaSDK && \
    dpkg -i /tmp/MediaSDK/libMediaSDK-dev_2.0-0_ubuntu18.04_amd64/libMediaSDK-dev_2.0-0_amd64_ubuntu18.04.deb
