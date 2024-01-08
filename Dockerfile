FROM nvidia/cuda:12.3.1-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y build-essential git cmake ninja-build \
    libgl1-mesa-dev libwayland-dev libxkbcommon-dev wayland-protocols libegl1-mesa-dev \
    libglew-dev libeigen3-dev \
    libjpeg-dev libpng-dev \
    libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libavdevice-dev \
    libssl-dev libopencv-dev libboost-dev libboost-serialization-dev \
    software-properties-common wget unzip \
    libspdlog-dev libboost-date-time-dev libboost-log-dev libyaml-cpp-dev libsuitesparse-dev \
    libcgal-dev qtbase5-dev qtbase5-dev-tools qt6-base-dev qt6-base-dev-tools

WORKDIR /app

# Pangolin
RUN cd /app && git clone https://github.com/stevenlovegrove/Pangolin.git && cd Pangolin && git checkout v0.8 && \
    mkdir -p build && cd build && cmake .. && make -j && make install && cd /app

# NumCpp
RUN cd /app && git clone https://github.com/dpilger26/NumCpp.git && cd NumCpp && git checkout a108470 && \
    mkdir -p build && cd build && cmake .. && cmake --build . --target install && cd /app

# g2o
RUN cd /app && git clone https://github.com/RainerKuemmerle/g2o.git && cd g2o && git checkout e8df200 && \
    mkdir -p build && cd build && cmake .. && make -j && make install && cd /app

# CCCoreLib
RUN cd /app && git clone --recursive https://github.com/CloudCompare/CCCoreLib.git && cd CCCoreLib && git checkout 02d7707 && \
    mkdir -p build && cd build && cmake .. && make -j && make install && cd /app

# Insta360 MediaSDK
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32 && \
    add-apt-repository -y "deb http://security.ubuntu.com/ubuntu xenial-security main" && \
    apt update && apt install -y libjasper1 libjasper-dev
RUN wget https://file.insta360.com/static/07814586d4c390c59ffaab8b90d09659/LinuxSDK20231211.zip -O /tmp/SDK.zip && \
    unzip /tmp/SDK.zip -d /tmp/SDK && \
    unzip /tmp/SDK/LinuxSDK20231211/libMediaSDK-dev_2.0-0_ubuntu18.04_amd64.zip -d /tmp/MediaSDK && \
    dpkg -i /tmp/MediaSDK/libMediaSDK-dev_2.0-0_ubuntu18.04_amd64/libMediaSDK-dev_2.0-0_amd64_ubuntu18.04.deb

# ORB_SLAM3
RUN cd /app && git clone https://github.com/infr-ai/ORB_SLAM3.git && cd ORB_SLAM3 && \
    ./build.sh && cd /app

# FBoW
RUN cd /app && git clone https://github.com/infr-ai/FBoW.git && cd FBoW && \
    mkdir -p build && cd build && cmake .. && make -j && make install && cd /app

