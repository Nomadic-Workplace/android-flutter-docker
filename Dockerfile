FROM cimg/android:2022.01.1

# Install and pre-cache Flutter.
RUN wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_2.8.0-stable.tar.xz && \
  sudo tar xf flutter_linux_2.8.0-stable.tar.xz -C /usr/local/bin && \
  rm flutter_linux_2.8.0-stable.tar.xz
RUN sudo chown -R $(whoami) /usr/local/bin/flutter

ENV PATH="/usr/local/bin/flutter/bin:${PATH}"

RUN /usr/local/bin/flutter/bin/flutter precache --no-web --no-linux --no-windows --no-fuchsia --no-ios --no-macos

RUN sudo apt update
RUN sudo apt install -y ruby ruby-dev rubygems
# Install fastlane.
RUN sudo gem install fastlane -NV
