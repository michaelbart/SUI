SDL=`cat sdl2-prefix`
ruby gen.rb ${SDL} > constants.c
gcc -I${SDL}/include -o constants constants.c
./constants > constants.swift
rm constants
rm constants.c

