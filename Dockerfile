# ------------------------------------------------------------
# Base Image (Ubuntu + CUDA 11.6 + cuDNN8)
# ------------------------------------------------------------
FROM nvidia/cuda:11.6.1-cudnn8-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

# ------------------------------------------------------------
# Basic system tools
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    git wget curl vim \
    build-essential \
    python3 python3-pip \
    python3-dev \
    libgl1-mesa-glx libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# pip 업데이트
RUN python3 -m pip install --upgrade pip

# ------------------------------------------------------------
# Install PyTorch (CUDA 11.6)
# ------------------------------------------------------------
RUN pip install torch==1.13.0+cu116 \
    torchvision==0.14.0+cu116 \
    torchaudio==0.13.0 \
    --extra-index-url https://download.pytorch.org/whl/cu116

# ------------------------------------------------------------
# Install core dependencies (MMCV/MMDet/MMSeg)
# ------------------------------------------------------------
RUN pip install mmcv==1.7.0
RUN pip install mmdet==2.28.2
RUN pip install mmsegmentation==0.30.0
RUN pip install openmim && mim install mmcv-full==1.7.0

# ------------------------------------------------------------
# Install SparseDrive-specific Python dependencies
# ------------------------------------------------------------
RUN pip install \
    nuscenes-devkit==1.1.10 \
    pyquaternion \
    shapely==1.8.5 \
    einops \
    IPython \
    matplotlib \
    opencv-python \
    tqdm \
    fire \
    pandas==1.1.5 \
    prettytable \
    tensorboard \
    scikit-learn==1.3.0

# FlashAttention (SparseDrive에서 사용하는 버전)
RUN pip install flash-attn==2.3.2 --no-build-isolation

# ------------------------------------------------------------
# Build deformable aggregation CUDA ops
# (나중에 컨테이너 내부에서 SparseDrive mount 후 수행)
# ------------------------------------------------------------
# 이 단계에서 SparseDrive 코드가 없으므로 build는 컨테이너 안에서 직접 실행해야 함:
# cd projects/mmdet3d_plugin/ops && python3 setup.py develop

# ------------------------------------------------------------
# Workspace
# ------------------------------------------------------------
WORKDIR /workspace

# ------------------------------------------------------------
# Default shell
# ------------------------------------------------------------
CMD ["/bin/bash"]
