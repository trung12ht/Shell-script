
#!/bin/bash

function upcasting()
{
    local src=$1 		#hocsinh
    local des=$2
    local this=$3

    for variable in $(compgen -A variable ${this}_)
    do
        for i_variable in $(compgen -A variable ${2}_)
	do   
            A="$(cut -d'_' -f2 <<<"$variable")"
	    B="$(cut -d'_' -f2 <<<"$i_variable")"
	    if [[ $A == $B ]]
	    then
                export ${i_variable/#$2\_/$this\_}="${i_variable} ${this}"
            fi
        done
    done
}
