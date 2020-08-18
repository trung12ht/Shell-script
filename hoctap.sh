
#!/bin/bash

# Base class. (1)
function hoctap()
{
    # A pointer to this Class. (2)
    local base=$FUNCNAME      # Vector        

    local this=$1             # vector1 

    # Declare methods. (5)
    for method in $(compgen -A function)
    do
        export ${method/\_}="${method} ${this}"
    done

}

function hoctap_hello()
{
    local base=$(expr "$FUNCNAME" : '\([a-zA-Z][a-zA-Z0-9]*\)')
    local this=$1
    echo "Can't call this function $base_ $this"
    exit 1
}

function hoctap_hoctap()
{
    local base=$(expr "$FUNCNAME" : '\([a-zA-Z][a-zA-Z0-9]*\)')
    local this=$1
    echo "Can't call this function $base_ $this"
    exit 1
}

