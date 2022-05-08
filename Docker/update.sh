#!/bin/bash

for d in ./*/ ; do (cd "$d" && docker compose pull && docker compose up --force-recreate --build -d); done