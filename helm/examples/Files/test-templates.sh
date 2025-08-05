#!/bin/bash

echo "=== Testing 01-files-get.yaml ==="
helm template . --name-template=my-release -s templates/01-files-get.yaml

echo -e "\n=== Testing 02-files-getbytes.yaml ==="
helm template . --name-template=my-release -s templates/02-files-getbytes.yaml

echo -e "\n=== Testing 03-files-glob.yaml ==="
helm template . --name-template=my-release -s templates/03-files-glob.yaml

echo -e "\n=== Testing 04-files-asconfig.yaml ==="
helm template . --name-template=my-release -s templates/04-files-asconfig.yaml

echo -e "\n=== Testing 05-files-assecrets.yaml ==="
helm template . --name-template=my-release -s templates/05-files-assecrets.yaml

echo -e "\n=== Testing 06-files-lines.yaml ==="
helm template . --name-template=my-release -s templates/06-files-lines.yaml 