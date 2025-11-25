# ------------------------------------------------------------
# Base Image (Ubuntu + CUDA 11.6 + cuDNN8)
# ------------------------------------------------------------
FROM nvidia/cuda:11.6.0-cudnn8-devel-ubuntu20.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# ------------------------------------------------------------
# Basic tools
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    vim \
    build-essential \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# Install Miniconda
# ------------------------------------------------------------
ENV CONDA_DIR=/opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p $CONDA_DIR && \
    rm /tmp/miniconda.sh
ENV PATH=$CONDA_DIR/bin:$PATH

# ------------------------------------------------------------
# Create Conda environment
# ------------------------------------------------------------
RUN conda create -n sparsedrive python=3.8 -y
SHELL ["bash", "-c"]
RUN echo "conda activate sparsedrive" >> ~/.bashrc
RUN conda init bash

# ------------------------------------------------------------
# Install PyTorch (CUDA 11.6)
# ------------------------------------------------------------
RUN source ~/.bashrc && conda activate sparsedrive && \
    pip install --upgrade pip && \
    pip install torch==1.13.0+cu116 torchvision==0.14.0+cu116 torchaudio==0.13.0 \
    --extra-index-url https://download.pytorch.org/whl/cu116

# ------------------------------------------------------------
# Clone SparseDrive (또는 컨테이너 빌드시 복사)
# ------------------------------------------------------------
WORKDIR /workspace
# 만약 Docker build 시 로컬 SparseDrive 폴더를 복사하고 싶으면:
# COPY SparseDrive-main /workspace/SparseDrive

# ------------------------------------------------------------
# Install dependencies
# ------------------------------------------------------------
RUN source ~/.bashrc && conda activate sparsedrive && \
    pip install mmcv==1.7.0 \
    && pip install mmdet==2.28.2 \
    && pip install mmsegmentation==0.30.0 \
    && pip install openmim && mim install mmcv-full==1.7.0 \
    && true

# 이후 requirement.txt는 컨테이너 시작 후 직접 설치하도록 유지

CMD ["/bin/bash"]
