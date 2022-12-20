#!/usr/bin/env bash

docker build -t test .

git clone --recurse-submodules https://github.com/nicolasfara/slides-template.git

docker run --rm --workdir="/github/workspace" -v "$(pwd)/slides-template":/github/workspace:rw test:latest 0.108.0 true '' slides.pdf '' slides-template/

test -f slides.pdf
