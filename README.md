# Introduction
This app

* observers a directory for incoming tv-captured ts files.
* encodes them as soon as recording is finished.
* manages the tv programs depending on epg information.
* provides a simple interface for watching them.

## Supported Environment
* Linux

#Installation

## Install Requirements

* TsSplitter (Windows)
* wine
* [ffmpeg](https://ffmpeg.org/trac/ffmpeg/wiki/UbuntuCompilationGuide)

## Setup Rails
    $ cd /path/to/this/app
    $ bundle install
    
## Configure Local Settings
    $ cp config/settings.local.sample.yml config/settings.local.yml

then, edit the file

## Setup Observer
Watch some directories to find incoming ts files, which are encoded and stored.

    $ crontab -e

add a line like

    */1 * * * * cd /path/to/this/app; oldest=`ruby bin/find_oldest_unchanged /path/where/ts/are/added 60.0`;if test "$oldest"; then RAILS_ENV=production rails r bin/register_movie $oldest 2>&1; fi
