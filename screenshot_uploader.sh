#!/usr/bin/env bash

client_id=${1:-$CLIENT_ID}
log_file=${2:-$LOG_FILE}
screenshot_folder=${3:-$SCREENSHOT_FOLDER}

touch $log_file

set -x

created_file() {
    inotifywait -e create $screenshot_folder --format "%f"
}

upload_to_dropbox() {
    local upload_path=/Screenshots/$(basename "$1")

    curl "https://content.dropboxapi.com/2/files/upload" \
         -H "Authorization: Bearer ${client_id}" \
         ""-H 'Content-Type: application/octet-stream' \
         -H "Dropbox-API-Arg: {\"path\":\"$upload_path\"}" \
         --data-binary @"$1"
}

create_link() {
    local upload_path=/Screenshots/$(basename "$1")

    curl -X POST https://api.dropboxapi.com/2/sharing/create_shared_link \
         --header "Authorization: Bearer ${client_id}" \
         --header "Content-Type: application/json" \
         --data "{\"path\": \"$upload_path\"}" | jq '.url'
}

dialog() {
    notify-send "Screenshot saved to dropbox" "$1"
}

while true; do
    screenshot_file=$(created_file)
    sleep 3 # without the sleep we end up with an empty file.... file system not ready?
    if [[ "$screenshot_file" =~ "png" ]]; then
        upload_to_dropbox "${screenshot_folder}/${screenshot_file}"

        image_url=$(create_link "${screenshot_folder}/${screenshot_file}")

        if [ $? -eq 0 ]; then
            dialog "$image_url"
            echo $image_url | sed 's/"//g' | xsel --clipboard --keep
        else
            dialog "Something went wrong $(tail -5 $log_file)"
        fi
    fi
done
