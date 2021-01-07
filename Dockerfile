FROM ubuntu:18.04

# FROM nvidia/cuda:10.2-cudnn7-runtime-ubuntu18.04
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

RUN apt update \
    && apt install -y htop python3-dev wget

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir root/.conda \
    && sh Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh

RUN conda create -y -n ml python=3.7

COPY . src/
RUN /bin/bash -c "cd src \
    && source activate ml \
    && pip install -r requirements.txt \
    && pip install torch==1.7.1+cpu -f https://download.pytorch.org/whl/torch_stable.html"
    
# WORKDIR src
# RUN ["/bin/bash", "-c", "source activate"]
# RUN ["/bin/bash", "-c", "pip install -r requirements.txt"]
# RUN ["/bin/bash", "-c", "pip install torch"]
