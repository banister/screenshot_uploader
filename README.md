# screenshot_uploader

auto-uploader to dropbox for screenshots taken in linux/ubuntu

![img](https://www.dropbox.com/s/4mq0jw6i9dsq9nl/Screenshot%20from%202018-01-24%2012-54-57.png?raw=1)

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
* We also display a popup notification (using `notify-send`) with the new dropbox link for the image
* Tries to add the link to clipboard but this is unreliable on Ubuntu :/

