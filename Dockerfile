# Dockerfile
FROM --platform=linux/amd64 mambaorg/micromamba:1.5.8

LABEL maintainer="azuza@mlw.mw"

RUN micromamba install -y -n base -c conda-forge -c bioconda \
       fastqc=0.12.1 \
       trimmomatic=0.39 \
       iqtree=2.3.3 \
       snippy=4.6.0 && \
    micromamba clean --all --yes

# Set the working directory
WORKDIR /data

# Entry point command
ENTRYPOINT ["bash"]
