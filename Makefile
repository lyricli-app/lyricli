configuration = debug
build_path = .build

# These are used to rename the executable to lrc without renaming the package
source_binary_name = lyricli
target_binary_name = lrc
install_path = /usr/local/bin
source_binary_path = $(build_path)/$(configuration)/$(source_binary_name)
install_binary_path = $(install_path)/$(target_binary_name)

# Default to release configuration on install
install: configuration = release

default: build

build:
	swift build --build-path $(build_path) --configuration $(configuration)

install: build
	cp $(source_binary_path) $(install_binary_path)

test: build
	swift test

lint:
	cd Sources && swiftlint

document: build
	sourcekitten doc --spm-module $(source_binary_name) > $(build_path)/$(source_binary_name).json
	jazzy \
		-s $(build_path)/$(source_binary_name).json \
		--readme README.md \
		--clean \
		--author Lyricli \
		--author_url https://github.com/lyricli-app \
		--github_url https://github.com/lyricli-app/lyricli \
		--module-version 0.4.0 \
		--module Lyricli \

clean:
	swift build --clean

.PHONY: build install test clean lint
