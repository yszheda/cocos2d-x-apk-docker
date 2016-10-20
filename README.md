# cocos2d-x-apk-docker

Build android apk of [cocos2d-x](https://github.com/cocos2d/cocos2d-x) or [quick-cocos2d-x](https://github.com/dualface/v3quick) game in Docker.

[![](https://images.microbadger.com/badges/image/galoisplusplus/quick-x-apk-docker.svg)](https://microbadger.com/images/galoisplusplus/quick-x-apk-docker "Get your own image badge on microbadger.com")

I use the following versions of packages, please adapt the `Dockerfile` if you need different versions:

- android-sdk r24.4.1
- android-20
- build-tools-20.0.0
- android-ndk r10e
- glfw v3.0.4
- cocos2d-console v3
- quick-cocos2d-x from https://github.com/dualface/v3quick

## usage

- Build android apk of cocos2d-x game:

```
docker run -d -v <path of your code>:/opt/proj galoisplusplus/quick-x-apk-docker:cocos2d-x
```

- Build android apk of quick-cocos2d-x game:

```
docker run -d -v <path of your code>:/opt/proj galoisplusplus/quick-x-apk-docker:quick-x
```
