#!/bin/bash

#cat >${TYPE}Properties.swift <<END
#END

rm -f LinuxMain.swift
touch LinuxMain.swift

for testModule in `ls -d -- *Tests` ; do
  echo '@testable import' ${testModule} >>LinuxMain.swift;
done

echo >>LinuxMain.swift
echo 'import Quick' >>LinuxMain.swift
echo >>LinuxMain.swift
echo 'QCKMain([' >>LinuxMain.swift

for testModule in `ls -d -- *Tests` ; do
  for testFile in `ls ${testModule}|grep Spec\.swift$|sed -e 's/\(.*\).swift/\1/g'` ; do
    echo "  ${testFile}.self," >>LinuxMain.swift;
  done;
done

echo '])' >>LinuxMain.swift

