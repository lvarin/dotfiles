#!/bin/bash
./run_test.sh RUNNER=cwl-tes EXTRA="--tes https://csc-tesk-noauth.rahtiapp.fi/ --remote-storage-url ftp://vm2722.kaj.pouta.csc.fi/upload" -j8 --junit-xml=${PWD}/tesk_required_cwl_v1_0.xml --tags=required
