#!/bin/sh
ary=('item0' 'item1' 'item2')
v='item1'

echo "${ary[@]/$v}"
if [[ "${ary[@]/$v}" != "${ary[@]}" ]];then
    echo "Found"
fi

read -p "continue.." var