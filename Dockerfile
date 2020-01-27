FROM ubuntu:18.04
ENV PATH /opt/conda/bin:$PATH
RUN mkdir /home/dronelab && \
    mkdir /home/dronelab/Developer
COPY xilinx_dnndk_v3.1_190809.tar.gz /home/dronelab/Developer

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    tar \
    vim \
    wget && \
    \
    tar -xvzf /home/dronelab/Developer/xilinx_dnndk_v3.1_190809.tar.gz -C /home/dronelab/Developer && \
    rm /home/dronelab/Developer/xilinx_dnndk_v3.1_190809.tar.gz && \
    \
    wget --quiet https://repo.anaconda.com/miniconda/Miniconda2-4.7.12.1-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    /bin/bash -c "source ~/.bashrc" && \
    conda create -n decent pip python=3.6

SHELL ["/bin/bash", "-c"]
RUN source activate decent && \
    pip install /home/dronelab/Developer/xilinx_dnndk_v3.1/host_x86/decent-tf/ubuntu18.04/tensorflow-1.12.0-cp36-cp36m-linux_x86_64.whl && \
    #pip install numpy opencv-python sklearn scipy progressbar2
    conda install numpy opencv sklearn scipy progresbar2 pillow

WORKDIR /home/dronelab/Developer/xilinx_dnndk_v3.1/host_x86
SHELL ["/bin/bash", "-c"]
RUN "./install.sh" || true

WORKDIR /home/dronelab
