FROM fedora:34

ARG OPENCV_VERSION

WORKDIR /opt/build

RUN set -ex \
    && dnf -q install -y \
        gcc gcc-c++ \
        make cmake \
        wget unzip \
        hdf5 \
        libjpeg-turbo libjpeg-turbo-devel \
        libpng libpng-devel \
        libtiff libtiff-devel \
        libwebp libwebp-devel \
        openjpeg2 openjpeg2-devel \
        tbb tbb-devel \
        eigen3 \
        openblas openblas-devel \
        protobuf protobuf-devel \
        tesseract tesseract-langpack-por tesseract-devel \
        python3-numpy python3-devel \
        python3 \
        kernel-headers \
   && dnf -q clean all
RUN dnf -q install -y python3-pip
ADD . /opt/build
RUN pip install -r requirements.txt
RUN dnf -q remove -y \
        gcc gcc-c++ \
        make cmake \
        libjpeg-turbo-devel \
        libpng-devel \
        libtiff-devel \
        libwebp-devel \
        openjpeg2-devel \
        tbb-devel \
        protobuf-devel \
        tesseract-devel \
        python3-devel \
        kernel-headers \
