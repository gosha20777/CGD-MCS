FROM nvidia/cuda:11.7.0-base-ubuntu22.04
RUN apt update && \
    apt install -y wget ffmpeg libsm6 libxext6 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
RUN useradd -ms /bin/bash ubuntu
USER ubuntu
# Install miniconda
ENV PATH="/home/ubuntu/miniconda3/bin:${PATH}"
ARG PATH="/home/ubuntu/miniconda3/bin:${PATH}"
WORKDIR /home/ubuntu

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir .conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 

RUN conda init bash
RUN conda install pytorch torchvision torchaudio cudatoolkit=11.3 -c pytorch -y \
    && conda install jupyter -y \
    && bash -c "pip install opencv-python thop onnx albumentations"


EXPOSE 8888

CMD bash -c "jupyter notebook --no-browser --ip=0.0.0.0"