# screenshot_uploader

auto-uploader to dropbox for screenshots taken in linux/ubuntu

![img](https://www.dropbox.com/s/4mq0jw6i9dsq9nl/Screenshot%20from%202018-01-24%2012-54-57.png?raw=1)

## Preamble

I wrote this because I couldn't find a good screenshot/autoupload tool for Ubuntu. It was frustrating, so I wrote one myself.

Written in pure bash. No need for Ruby or anything like that.

## Use:

* Relies on `inotify-tools` and `jq` (for processing JSON on command line) `sudo apt install inotify-tools jq`
* First set the `CLIENT_ID` environment var (dropbox API key)
* Set the `LOG_FILE` env var, logs are stored here
* Set the `SCREENSHOT_FOLDER` env var, this is the folder watched
* Alternatively, when invoking `screenshot_uploader.sh` pass the above as commandline arguments. `$1` is `CLIENT_ID`, and so on.

## Add to the end of ~/.bashrc

```
if [ ! -f /tmp/screenshot-uploader.pid ]; then
    echo "starting screenshot uploader in background"
    nohup ~/code/bin/screenshot-uploader.sh  > /dev/null 2>&1 &
fi
```

NOTE: cannot add a systemd unit as the clipboard code won't work - only way for clipboard to work is to load it in .bashrc

## Features:

* Watches a specified folder for changes
* When a new file is added and it's a png then we upload it to dropbox
* We also display a popup notification (using `notify-send`) with the new dropbox link for the image
* Tries to add the link to clipboard but this is unreliable on Ubuntu :/
