# Lyricli (lrc)

A command line tool to show the lyrics of your current song.

## Usage

Lyricli can be invoked with the command `lrc`. It can be invoked without
arguments, with an artist and song or with a special command:

```
$ lrc [-t]
```

When you run it without arguments, it will look in the available source
to try to find a playing song and extract the lyrics. If you include the
`-t` flag, it will show the song and artist names before the lyrics.

```
$ lrc [-t] <artist_name> <song_name>
```

When you run it with arguments, it will use them to search for the
lyrics. This won't work if you manually disable the arguments source in
your configuration file. If you include the `-t` flag, it will show the
song and artist names before the lyrics.

### Commands

In order to configure

* `lrc -l` or `lrc --list-sources` lists the available sources. Enabled
  sourcess will have a `*`
* `lrc -e` or `lrc --enable <source>` enables a source
* `lrc -d` or `lrc --disable <source>` disables a source
* `lrc -r` or `lrc --reset-source <source>` resets the configuration for
  a source and disables it.
* `lrc -v` or `lrc --version` prints the version
* `lrc -h` or `lrc --help` display built-in help

## Building

The build has only been tested on OSX using Swift 3.1. Building defaults
to the debug configuration.

```
make
```

## Installing from source

Builds lyricli in release configuration and copies the executable as
`lrc` to `/usr/local/bin`

```
make install
```

### Installing to a custom directory

This can be done by overriding the `install_path` variable

```
make install install_path=/opt/bin
```

## Running tests

No tests at the moment 😬... but the makefile is mapped to run the swift
tests.

```
make test
```
