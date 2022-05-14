#!/bin/bash

git pull

for d in ./*/ ; do (cd "$d" && docker compose pull && docker compose up --build -d); done
