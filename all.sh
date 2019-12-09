#!/bin/bash
echo "[*] Grabbing AWS CIDR [*]"
./aws.sh >> tmp.txt
echo "[*] Grabbing Azure CIDR  [*]"
./azure.sh >> tmp.txt
echo "[*] Grabbing Google CIDR [*]"
./gcloud.sh | grep -F '.' >> tmp.txt
echo "[*] Grabbing Oracle CIDR [*]"
./oracle.sh >> tmp.txt
cat tmp.txt | sort -u >> all.txt
echo "[*] Done [*]"
