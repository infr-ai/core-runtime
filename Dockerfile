FROM nvidia/cuda:12.3.1-devel-ubuntu22.04

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

# NumCpp
RUN cd /app && git clone --recursive https://github.com/dpilger26/NumCpp.git && cd NumCpp && git checkout a108470 && \
    mkdir -p build && cd build && cmake .. && cmake --build . --target install && cd /app

# Insta360 MediaSDK
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32 && \
    add-apt-repository -y "deb http://security.ubuntu.com/ubuntu xenial-security main" && \
    apt update && apt install -y libjasper1 libjasper-dev
RUN wget https://file.insta360.com/static/07814586d4c390c59ffaab8b90d09659/LinuxSDK20231211.zip -O /tmp/SDK.zip && \
    unzip /tmp/SDK.zip -d /tmp/SDK && \
    unzip /tmp/SDK/LinuxSDK20231211/libMediaSDK-dev_2.0-0_ubuntu18.04_amd64.zip -d /tmp/MediaSDK && \
    dpkg -i /tmp/MediaSDK/libMediaSDK-dev_2.0-0_ubuntu18.04_amd64/libMediaSDK-dev_2.0-0_amd64_ubuntu18.04.deb

# ORB_SLAM3
RUN cd /app && git clone --recursive https://github.com/infr-ai/ORB_SLAM3.git && cd ORB_SLAM3 && \
    ./build.sh && cd /app

RUN cp /app/ORB_SLAM3/Vocabulary/ORBvoc.txt /app/orb_vocab.txt

# # g2o
# RUN cd /app && git clone --recursive https://github.com/RainerKuemmerle/g2o.git && cd g2o && git checkout e8df200 && \
#     mkdir -p build && cd build && cmake .. && make -j && make install && cd /app
    
# # FBoW
# RUN cd /app && git clone --recursive https://github.com/infr-ai/FBoW.git && cd FBoW && \
#     mkdir -p build && cd build && cmake .. && make -j && make install && cd /app

# # stella_vslam
# RUN cd /app && git clone --recursive https://github.com/infr-ai/stella_vslam.git && cd stella_vslam && \
#     mkdir -p build && cd build && cmake .. && make -j && make install && cd /app

# # stella_pangolin_viewer
# RUN cd /app && git clone --recursive https://github.com/infr-ai/pangolin_viewer.git && cd pangolin_viewer && \
#     mkdir -p build && cd build && cmake .. && make -j && make install && cd /app

# # stella_vslam_examples
# RUN cd /app && git clone --recursive https://github.com/infr-ai/stella_vslam_examples.git && cd stella_vslam_examples && \
#     mkdir -p build && cd build && cmake .. && make -j && cd /app

# # CCCoreLib
# RUN cd /app && git clone --recursive https://github.com/CloudCompare/CCCoreLib.git && cd CCCoreLib && git checkout 02d7707 && \
#     mkdir -p build && cd build && cmake .. && make -j && make install && cd /app

# RUN wget https://github.com/stella-cv/FBoW_orb_vocab/raw/main/orb_vocab.fbow -O /app/orb_vocab.fbow
