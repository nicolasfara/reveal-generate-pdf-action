#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
    echo 'No arguments supplied'
    exit 1
fi

hugo_version=$1
hugo_extended=${2:-"true"}
working_dir=${3:-"./"}
pdf_file=${4:-"slides.pdf"}
hugo_url=""

if [[ $hugo_extended == "true" ]]; then
    hugo_url=https://github.com/gohugoio/hugo/releases/download/v${hugo_version}/hugo_extended_${hugo_version}_linux-amd64.deb 
    echo $hugo_url
    wget -O hugo.deb $hugo_url
else
    hugo_url=https://github.com/gohugoio/hugo/releases/download/v${hugo_version}/hugo_${hugo_version}_linux-amd64.deb
    echo $hugo_url
    wget -O hugo.deb $hugo_url
fi

dpkg -i hugo.deb
npm install -g decktape

cd $working_dir || exit 255

if [[ -f "config.toml" ]]; then
    echo "config.toml exists... starting hugo server"
else
    echo "'config.toml' not found!"
    exit 1
fi

hugo server &
decktape reveal http://localhost:1313/ $pdf_file || exit 2

# Stop hugo server
kill -KILL $! || exit 3
