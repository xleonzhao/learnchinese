#!/usr/bin/env bash

ssh imac 'cd Public/tmp; screencapture t.jpg'
scp imac:Public/tmp/t.jpg .
ssh imac 'rm -rf Public/tmp/t.jpg'
open t.jpg
read x
rm t.jpg
