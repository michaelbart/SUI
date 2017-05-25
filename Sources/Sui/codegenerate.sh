#!/bin/bash
cd $(dirname $0)

#codegenerate StyleProperties.swift
TYPE=Style ../Properties/Properties.sh

#codegenerate WidgetProperties.swift
TYPE=Widget FOR_TYPE=Widget ../Properties/Properties.sh

