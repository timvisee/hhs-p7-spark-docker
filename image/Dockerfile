# Base image
FROM alpine:latest

# Maintainer
MAINTAINER Tim Visée <timvisee@gmail.com>

# Define the user
USER root

# Upgrade and install required packages
RUN apk update \
 && apk upgrade \
 && apk add sudo bash wget git bzip2 unzip zlib curl ca-certificates libstdc++ glib libxext libxrender tini \
 && curl -L "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/2.23-r1/glibc-2.23-r1.apk" -o /tmp/glibc.apk \
 && curl -L "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/2.23-r1/glibc-bin-2.23-r1.apk" -o /tmp/glibc-bin.apk \
 && curl -L "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/2.23-r1/glibc-i18n-2.23-r1.apk" -o /tmp/glibc-i18n.apk \
 && apk add --allow-untrusted /tmp/glibc*.apk \
 && /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib \
 && /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8

# Configure environment
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH
ENV SHELL /bin/sh
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Configure Miniconda
ENV MINICONDA_VER 4.2.12
ENV MINICONDA Miniconda3-$MINICONDA_VER-Linux-x86_64.sh
ENV MINICONDA_URL https://repo.continuum.io/miniconda/$MINICONDA
ENV MINICONDA_MD5_SUM d0c7c71cc5659e54ab51f2005a8d96f3

# Install Miniconda
RUN cd /tmp \
 && mkdir -p $CONDA_DIR \
 && wget $MINICONDA_URL -O miniconda.sh \
 && echo "$MINICONDA_MD5_SUM  miniconda.sh" | md5sum -c - \
 && sudo bash miniconda.sh -f -b -p $CONDA_DIR \
 && rm miniconda.sh \
 && $CONDA_DIR/bin/conda install --yes conda==$MINICONDA_VER

# Delete cache
RUN rm -rf /var/cache/apk/* \
 && rm -rf /tmp/glibc*apk \
 && rm -rf /root/.cache
