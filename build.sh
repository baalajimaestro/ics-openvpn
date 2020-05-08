#! /bin/bash
#
# Copyright © 2020 Maestro Creativescape
#
# SPDX-License-Identifier: GPL-3.0
#
# CI Runner Script for building apps

echo "**MaestroCI App Builder**"
mkdir -p ~/.ssh
curl -sL -u baalajimaestro:$GH_PERSONAL_TOKEN -o /home/ci/.ssh/id_ed25519 https://raw.githubusercontent.com/baalajimaestro/keys/master/id_ed25519
chmod 600 ~/.ssh/id_ed25519
echo "SSH Keys Set!"

while true; do echo "Building Your App....."; sleep 120; done &

./gradlew assembleUiRelease > /dev/null
jobs
kill %1

mkdir main/build/outputs/apk/ui/release/$(date +%d%m%Y)
mv main/build/outputs/apk/ui/release/main-ui-universal-release.apk main/build/outputs/apk/ui/release/$(date +%d%m%Y)/OpenVPN-XOR-Android-Universal.apk
mv main/build/outputs/apk/ui/release/main-ui-x86-release.apk main/build/outputs/apk/ui/release/$(date +%d%m%Y)/OpenVPN-XOR-Android-x86.apk
mv main/build/outputs/apk/ui/release/main-ui-armeabi-v7a-release.apk main/build/outputs/apk/ui/release/$(date +%d%m%Y)/OpenVPN-XOR-Android-armeabi-v7a.apk
mv main/build/outputs/apk/ui/release/main-ui-arm64-v8a-release.apk main/build/outputs/apk/ui/release/$(date +%d%m%Y)/OpenVPN-XOR-Android-arm64.apk
mv main/build/outputs/apk/ui/release/main-ui-x86_64-release.apk main/build/outputs/apk/ui/release/$(date +%d%m%Y)/OpenVPN-XOR-Android-amd64.apk
rm main/build/outputs/apk/ui/release/output.json

scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -r main/build/outputs/apk/ui/release/$(date +%d%m%Y) baalaji20@storage.osdn.net:/storage/groups/b/ba/baalajimaestrobuilds/openvpn-xor-android/$(date +%d%m%Y)