# Dockerfile
FROM --platform=linux/amd64 ubuntu:23.04
USER root

LABEL maintainer="azuza@mlw.mw"

RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y python3-pip python3-dev build-essential wget

RUN wget -c https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh

RUN conda -v
RUN conda install -y -n base -c conda-forge -c bioconda \
       fastqc=0.12.1 \
       trimmomatic=0.39 \
       iqtree=2.3.3 \
       snippy=4.6.0

# Set the working directory
WORKDIR /tmp

# Entry point command
ENTRYPOINT ["bash"]
