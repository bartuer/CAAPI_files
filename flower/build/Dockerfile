FROM ubuntu:14.04
MAINTAINER Bartuer Zhou <bazhou@microsoft.com>

COPY tar /opt/tar

RUN apt-get update && \
    apt-get install -y \
    git build-essential cmake \
    libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev \
    libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler \
    libgflags-dev libgoogle-glog-dev liblmdb-dev \
    python-dev python-pip  && \
    apt-get install -y --no-install-recommends libboost-all-dev 

WORKDIR /opt/tar/opencv-3.0.0/release

RUN NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
    cmake –D CMAKE_BUILD_TYPE=Release –D CMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j${NPROC} install
    
WORKDIR /opt/tar/OpenBLAS-0.2.19

RUN NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
    make -j${NPROC} && make install

WORKDIR /opt/tar/caffe

RUN apt-get install -y cython python-numpy python-scipy \
    python-skimage python-matplotlib ipython python-h5py \
    python-leveldb python-networkx python-nose python-pandas \
    python-dateutil python-protobuf \
    python-gflags python-yaml python-pil && pip install flask &&\
    rm -rf /var/lib/apt/lists/*

RUN NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
    make -j${NPROC} && \
    make pycaffe

ENV CAFFE_ROOT /opt/tar/caffe
ENV PYCAFFE_ROOT $CAFFE_ROOT/python
ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH
RUN echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && \
    echo "/opt/OpenBLAS/lib" >> /etc/ld.so.conf.d/openblas.conf && ldconfig

RUN rm -rf /opt/tar/opencv-3.0.0 && rm -rf /opt/tar/OpenBLAS-0.2.19

WORKDIR /ml/storage/code/flower
CMD ["python", "server.py"]
