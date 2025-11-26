# ------------------------------------------------------------
# Base Image
# ------------------------------------------------------------
FROM nvidia/cuda:11.6.1-cudnn8-devel-ubuntu20.04
ENV DEBIAN_FRONTEND=noninteractive

# ------------------------------------------------------------
# Basic tools
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    git wget curl vim \
    build-essential \
    python3 python3-pip \
    python3-dev \
    libgl1-mesa-glx libglib2.0-0 \
    libboost-all-dev \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --upgrade pip setuptools==59.5.0

# ------------------------------------------------------------
# PyTorch (CUDA 11.6)
# ------------------------------------------------------------
RUN pip install torch==1.13.0+cu116 \
    torchvision==0.14.0+cu116 \
    torchaudio==0.13.0 \
    --extra-index-url https://download.pytorch.org/whl/cu116

# ------------------------------------------------------------
# MMCV / MMDet / MMSeg / MMDet3D
# ------------------------------------------------------------
RUN pip install openmim && \
    mim install mmcv-full==1.7.0

RUN pip install mmdet==2.28.2
RUN pip install mmsegmentation==0.30.0
RUN pip install mmdet3d==1.0.0

# ------------------------------------------------------------
# SparseDrive dependencies
# ------------------------------------------------------------
RUN pip install \
    nuscenes-devkit==1.1.10 \
    pyquaternion \
    shapely==1.8.5 \
    einops \
    opencv-python \
    matplotlib \
    tqdm \
    fire \
    Pillow \
    pandas==1.1.5 \
    prettytable \
    tensorboard \
    scikit-learn==1.3.0 \
    numba \
    pycocotools \
    scipy \
    seaborn \
    yacs \
    networkx

# FlashAttention (SparseDrive 호환 버전)
RUN pip install flash-attn==2.1.3 --no-build-isolation

# ------------------------------------------------------------
# Workspace
# ------------------------------------------------------------
WORKDIR /workspace

CMD ["/bin/bash"]
