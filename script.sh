#!/bin/sh
trap 'curl -s "http://localhost:4000/stream/unpublish?name=$RTSP_PATH&streamType=RTSP"; [ -z "$(jobs -p)" ] || kill $(jobs -p)' INT
curl -s "http://localhost:4000/stream/publish?name=$RTSP_PATH&streamType=RTSP"
sleep 86400 &
wait