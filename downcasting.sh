#!/bin/bash

function downcasting()
{
    local src=$1 		#hocsinh
    local des=$2
    local this=$3
    
    for e_method in $(compgen -A function ${des}_)
    do
        export ${e_method/#$des\_/$this\_}="${e_method} ${this}"
    done
}
