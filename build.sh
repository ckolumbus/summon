#!/bin/bash

rm -rf pkg

docker build -t cauldron/build .

projectpath="/goroot/src/github.com/conjurinc/cauldron"
buildcmd='xargs -L1 go get <Godeps && cd example; GOX_OS="darwin linux windows" GOX_ARCH="amd64" gox -verbose -output "../pkg/{{.OS}}_{{.Arch}}/{{.Dir}}"'

docker run --rm \
-v "$(pwd)":"${projectpath}" \
-w "${projectpath}" \
cauldron/build \
bash -c "${buildcmd}"