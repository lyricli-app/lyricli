ARG swift_version=latest
FROM swift:${swift_version}

RUN apt-get update && apt-get install -y \
  libsqlite3-dev \
  ruby \
  ruby-dev \
  wget \
	&& rm -rf /var/lib/apt/lists/*

RUN gem install --no-ri --no-rdoc jazzy

# SourceKitten

RUN git clone https://github.com/jpsim/SourceKitten.git /tmp/SourceKitten \
  && cd /tmp/SourceKitten \
  && make install \
  && rm -rf /tmp/SourceKitten

# Swiftlint

RUN git clone https://github.com/realm/SwiftLint.git /tmp/SwiftLint \
  && cd /tmp/SwiftLint \
  && git submodule update --init --recursive \
  && make install \
  && rm -rf /tmp/SwiftLint
