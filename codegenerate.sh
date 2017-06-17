#!/bin/bash
cd $(dirname $0)

swift package generate-xcodeproj

./Sources/SdlSui/codegenerate.sh
./Tests/codegenerate.sh

