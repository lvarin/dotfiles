#!/bin/bash
#
IMAGE='docker-registry.rahti.csc.fi/cscfi/elmerfem:devel'
#
docker pull $IMAGE
docker run -it --rm -v ~/elmer-cases/:/elmer-cases/ $IMAGE
