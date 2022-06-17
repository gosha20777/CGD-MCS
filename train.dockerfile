FROM nvidia/cuda:11.6.2-base-ubuntu20.04
RUN apt update && \
    apt install -y wget ffmpeg libsm6 libxext6 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
# Install miniconda
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
WORKDIR /root/

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 

RUN conda init bash
RUN conda install pytorch torchvision torchaudio cudatoolkit=11.3 -c pytorch -y \
    && conda install jupyter pandas -y \
    && bash -c "pip install opencv-python thop onnx albumentations protobuf==3.20.*"


EXPOSE 8888

CMD bash -c "jupyter notebook --no-browser --allow-root --ip=0.0.0.0"
