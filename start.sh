#!/bin/bash
trap ctrl_c INT

# kill app processes from this script when ctrl_c() is called
function ctrl_c() {
    echo "Exiting..."
    pkill -P $$
    exit
}

# directory where app and server are
cd yourArea

echo "Starting server..."
./run.sh &

echo "Opening Firefox..."
firefox "./app.html"&

wait
