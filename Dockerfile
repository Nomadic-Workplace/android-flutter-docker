FROM cimg/android:2022.01.1

RUN sudo apt-get update && \
    sudo apt-get install -y bash curl file git unzip xz-utils zip libglu1-mesa

# Install fastlane.
RUN sudo apt-get install -y ruby ruby-dev rubygems
RUN sudo gem install fastlane -NV

# Install and pre-cache Flutter.
ARG flutterVersion=stable

WORKDIR /usr/local/bin

ADD https://api.github.com/repos/flutter/flutter/compare/${flutterVersion}...${flutterVersion} /dev/null

RUN sudo git clone https://github.com/flutter/flutter.git -b ${flutterVersion} flutter

RUN sudo chown -R $(whoami) /usr/local/bin/flutter

RUN flutter/bin/flutter precache

RUN flutter/bin/flutter config --no-analytics

ENV PATH="/usr/local/bin/flutter/bin:${PATH}"
ENV PATH="/usr/local/bin/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter doctor

