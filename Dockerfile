FROM ubuntu:14.04

MAINTAINER galois "yszheda@gmail.com"

########################################
# Install required packages
# NOTE: add "RUN DEBIAN_FRONTEND=noninteractive" to set noninteractive ENV for the command.
RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq

# Install add-apt-repository
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python-software-properties software-properties-common

# Install oracle java
RUN echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:webupd8team/java \
    && apt-get update -qq
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential \
    wget \
    zip \
    unzip \
    php5 \
    python \
    oracle-java6-installer \
    ant \
    libx11-dev \
    libxmu-dev \
    libglu1-mesa-dev \
    libgl2ps-dev \
    libxi-dev \
    g++ \
    libzip-dev \
    libpng12-dev \
    libcurl4-gnutls-dev \
    libfontconfig1-dev \
    libsqlite3-dev \
    libglew*-dev \
    libssl-dev \
    libgnutls-dev \
    xorg-dev \
    libglu1-mesa-dev \
    cmake \
    lib32stdc++6 \
    lib32z1

########################################
# Set ant environment
ENV ANT_ROOT /usr/bin

########################################
# Install Android SDK
ENV ANDROID_SDK_ROOT /opt/android-sdk-linux

RUN cd /opt && wget -q https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz -O android-sdk.tgz \
    && tar -zxvf android-sdk.tgz \
    && rm -f android-sdk.tgz

ENV PATH ${PATH}:${ANDROID_SDK_ROOT}:${ANDROID_SDK_ROOT}/tools

RUN echo y | android update sdk --no-ui --all --filter platform-tools | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter extra-android-support | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-20 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-20.0.0 | grep 'package installed'

########################################
# Install Android NDK
ENV ANDROID_NDK_ROOT /opt/android-ndk-r10e
ENV NDK_ROOT /opt/android-ndk-r10e

RUN cd /opt && wget -q http://dl.google.com/android/repository/android-ndk-r10e-linux-x86_64.zip -O android-ndk.zip \
    && unzip -q android-ndk.zip \
    && rm -f android-ndk.zip

ENV PATH ${PATH}:${ANDROID_NDK_ROOT}

########################################
# Install glfw
ENV GLFW_VERSION "3.0.4"
ENV GLFW_SOURCE "https://codeload.github.com/glfw/glfw/tar.gz/${GLFW_VERSION}"

RUN mkdir /opt/glfw \
    && cd /opt/glfw \
    && wget -q https://codeload.github.com/glfw/glfw/tar.gz/${GLFW_VERSION} -O glfw.tar.gz \
    && tar xzf glfw.tar.gz \
    && cd ./glfw-${GLFW_VERSION} \
    && cmake -G "Unix Makefiles" -DBUILD_SHARED_LIBS=ON \
    && make \
    && make install \
    && ldconfig \
    && rm -rf /opt/glfw

########################################
# Set cocos2d-x environment
# Only need cocos2d-console since the source code of cocos2d-x will be included in your project.
ENV COCOS_X_CONSOLE_ROOT /opt/cocos2d-console/bin
RUN cd /opt && git clone https://github.com/cocos2d/cocos2d-console.git
ENV PATH ${PATH}:${COCOS_X_CONSOLE_ROOT}

########################################
# Set quick-x environment
ENV QUICK_V3_ROOT /opt/v3quick-3
RUN cd /opt && wget https://codeload.github.com/dualface/v3quick/tar.gz/v3 -O /tmp/v3quick.tar.gz \
    && tar zxf v3quick.tar.gz \
    && rm -rf /opt/v3quick.tar.gz

########################################
# Cleaning
RUN apt-get clean
