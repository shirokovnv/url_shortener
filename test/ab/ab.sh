#!/bin/bash

echo "Write some URLS:\r\n"

ab -p post-file.txt -T application/json -k -c 100 -n 1000 http://localhost:4000/

echo "Read some URLS:\r\n"

ab -k -c 100 -n 1000 http://localhost:4000/1