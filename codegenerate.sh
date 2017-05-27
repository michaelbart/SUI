#!/bin/bash
cd $(dirname $0)

./Sources/SdlSui/codegenerate.sh
./Tests/codegenerate.sh

