#!/usr/bin/env bash
#
rsync -avzh  --port 2223 -P rsync://10.11.1.15/docker .
