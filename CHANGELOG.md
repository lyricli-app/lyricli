# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]
### Added
- `printLyrics(_ currentTrack: Track)` allows directly specifying
  track in library
- `lyricli_command` specifies the flags
- Support for catalina Music app

### Changed
- CI scripts updated for gitlab CI instead of Travis
- Flags are now single words
- Update to Swift 5 tools
- Replace CommandLineKit with Bariloche
- Reorganize sources folder
- Does not open apps when running

### Removed
- Arguments Source (functionality moved to main)

## [0.3.0]
### Added
- Spotify Source Support

### Changed
- Fix case where iTunes returned track when app was closed
- Fix structure and links in CHANGELOG.md

## [0.2.0]
### Added
- iTunes Source Support

### Changed
- Fix Lyricli freezes when no track found
- Fix README URLs

## 0.1.0 - 2017-05-20
### Added
- Documentation with Jazzy / SourceKitten
- Apache License
- Documentation to help use lyricli and contribute
- Makefile to help build and install
- CI integration
- Lyrics engine to fetch the lyrics from lyricswiki
- Arguments source to read song and artist from command line
- Parsing of options to match legacy lyricli
- Placeholder for the library with expected endpoints

[0.3.0]: https://github.com/lyricli-app/lyricli/compare/0.2.0...0.3.0
[0.2.0]: https://github.com/lyricli-app/lyricli/compare/0.1.0...0.2.0
[Unreleased]: https://github.com/lyricli-app/lyricli/compare/master...develop
