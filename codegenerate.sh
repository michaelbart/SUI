#!/bin/bash
cd $(dirname $0)

./Sources/Sui/codegenerate.sh
./Sources/SdlSui/codegenerate.sh
./Tests/PropertiesTests/codegenerate.sh
./Tests/codegenerate.sh

