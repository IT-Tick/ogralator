#!/bin/sh

mkdir -p secrets/
base64 -i android/play_config.json > secrets/play_config.json.b64
base64 -i android/upload-keystore.jks > secrets/upload-keystore.jks.b64
base64 -i android/key.properties > secrets/key.properties.b64
