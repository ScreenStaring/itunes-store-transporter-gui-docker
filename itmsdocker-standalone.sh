#!/bin/bash

shutdown() {
    trap - TERM
    kill -term 0
}

setup_volume() {
    local volume="/var/lib/itms"
    local output_dir="$volume/output"
    local db_dir="$volume/db"
    local db_name="itmsweb.sqlite3"

    [ ! -d "$output_dir" ] && mkdir "$output_dir"
    [ ! -d "$db_dir" ] && mkdir "$db_dir"
    [ ! -f "$db_dir/$db_name" ] && cp "/opt/itms/db/$db_name" "$db_dir"

    export ITMS_OUTPUT_LOG_DIRECTORY="$output_dir"
    export ITMS_DATABASE_URL="sqlite3:$db_dir/$db_name"
}

# Allow the user to specify an iTMSTransporter installer
install_transporter() {
    local command=$(ls -1 /installer/*.sh | head)
    chmod u+x "$command"

    eval "$command --accept --nox11 -q --target /tmp/ --noexec" && cp -R /tmp/itms /usr/local/
}

trap 'shutdown' TERM
set -e

setup_volume
[ -d /installer ] && install_transporter

./bin/itmsweb start -h 0.0.0.0 &
./bin/itmsworker &
wait
