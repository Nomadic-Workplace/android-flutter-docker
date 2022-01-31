FROM cimg/android:2022.01.1

RUN sudo apt-get update && \
    sudo apt-get install -y bash curl file git unzip xz-utils zip libglu1-mesa

# Install fastlane.
RUN sudo apt-get install -y ruby ruby-dev rubygems
RUN sudo gem install fastlane -NV

# Install and pre-cache Flutter.
RUN sudo groupadd -r -g 1441 flutter && sudo useradd --no-log-init -r -u 1441 -g flutter -m flutter

USER flutter:flutter

WORKDIR /home/flutter

ARG flutterVersion=stable

ADD https://api.github.com/repos/flutter/flutter/compare/${flutterVersion}...${flutterVersion} /dev/null

RUN git clone https://github.com/flutter/flutter.git -b ${flutterVersion} flutter-sdk

RUN flutter-sdk/bin/flutter precache

RUN flutter-sdk/bin/flutter config --no-analytics

ENV PATH="$PATH:/home/flutter/flutter-sdk/bin"
ENV PATH="$PATH:/home/flutter/flutter-sdk/bin/cache/dart-sdk/bin"

RUN flutter doctor

