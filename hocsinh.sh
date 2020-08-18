
#!/bin/bash

# Base class. (1)

. nguoi.sh
. hoctap.sh

function hocsinh()
{
    # A pointer to this Class. (2)
    local base=$FUNCNAME	# Vector	
    local this=$1 		# vector1 
 
    # Inherited classes (optional). (3)

    export ${this}_inherits="nguoi" # (3.1)
    # Implement interface (optional). (4)
    export ${this}_interfaces="hoctap" # (4.1)

    local class=$(eval "echo \$${this}_inherits")
    local interfaces=$(eval "echo \$${this}_interfaces")

    # Inherited construction  (5)
    eval "$class '$class' $2 $3"

    for property in $(compgen -A variable ${class}_)
    do
    	export ${property/#$class\_/$this\_}=$(eval "echo \$${property}")
    done
    for method in $(compgen -A function ${class}_)
    do
    	export ${method/#$class\_/$this\_}="${method} ${this}"
    done

    # Declare Properties. (6)
    export ${this}_lop=$4
    #export ${this}_y=$3
    #export ${this}_z=$4

    # Declare methods. (7)
    for e_method in $(compgen -A function ${base}_)
    do
        export ${e_method/#$base\_/$this\_}="${e_method} ${this}"
    done
    
    for interface in $interfaces
    do
	eval "$interface '$interface'" 
    
    	for i_property in $(compgen -A variable ${interface}_)
    	do
	    echo "32: Interface cannot have properties $i_property"
    	    exit 1
    	done
		
    	for i_method in $(compgen -A function ${interface}_)
    	do
	    flag='f'
    	    for method in $(compgen -A function ${class}_) 
    	    do
	    	A="$(cut -d'_' -f2 <<<"$method")"
	    	B="$(cut -d'_' -f2 <<<"$i_method")"
	    	if [[ $A == $B ]]
	    	then
		    flag='t'
	    	    break
	    	fi
	    done
	    for method in $(compgen -A function ${base}_) 
    	    do
	    	A="$(cut -d'_' -f2 <<<"$method")"
	    	B="$(cut -d'_' -f2 <<<"$i_method")"
	    	if [[ $A == $B ]]
	    	then
		    flag='t'
	    	    break
	    	fi
	    done
	    if [[ $flag == 'f' ]]
	    then
	        echo "method $i_method is not yet been implemented"
	        exit 1
    	    fi
    	done
    done
    
    CLASS=$class
}
 
# Human readable representation of the vector. (8)
function hocsinh_hello()
{
    local base=$(expr "$FUNCNAME" : '\([a-zA-Z][a-zA-Z0-9]*\)')
    local this=$1
	
    echo "hocsinh hello world"
}

function hocsinh_hoctap()
{
    local base=$(expr "$FUNCNAME" : '\([a-zA-Z][a-zA-Z0-9]*\)')
    local this=$1

    echo "hoctap"
}

function hocsinh_show()
{
    local base=$(expr "$FUNCNAME" : '\([a-zA-Z][a-zA-Z0-9]*\)')
    local this=$1
   
    ten=$(eval "echo \$${this}_ten") 
    tuoi=$(eval "echo \$${this}_tuoi")
    lop=$(eval "echo \$${this}_lop")
    echo "ten: $ten . tuoi: $tuoi . lop: $lop"
}
