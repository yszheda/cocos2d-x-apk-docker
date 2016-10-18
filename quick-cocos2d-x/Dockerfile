FROM galoisplusplus/quick-x-apk-docker:cocos2d-x

MAINTAINER galois "yszheda@gmail.com"

########################################
# Set quick-x environment
ENV QUICK_V3_ROOT /opt/v3quick-3
RUN cd /opt && wget https://codeload.github.com/dualface/v3quick/tar.gz/v3 -O v3quick.tar.gz \
    && tar zxf v3quick.tar.gz \
    && rm -rf /opt/v3quick.tar.gz

# Set project path
WORKDIR /opt/proj

ENTRYPOINT ["/bin/bash", "cocos", "-m", "debug", "-p", "android", "--compile-script", "0"]
