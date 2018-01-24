# screenshot_uploader

auto-uploader to dropbox for screenshots taken in linux/ubuntu

## Preamble

I wrote this because I couldn't find a good screenshot/autoupload tool for Ubuntu. It was frustrating, so I wrote one myself.

Written in pure bash. No need for Ruby or anything like that.

## Use:

* Relies on `inotify-tools`: `sudo apt install inotify-tools`
* First set the `CLIENT_ID` environment var (dropbox API key)
* Set the `LOG_FILE` env var, logs are stored here


## Features:

* Watches a specified folder for changes
* When a new file is added and it's a png then we upload it to dropbox
* We also display a notification with the new dropbox link for the image

