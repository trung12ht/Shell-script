#!/bin/bash
# while-menu: a menu driven system information program
DELAY=1 # Number of seconds to display results
while true; do
    clear
	cat << EOF
        Please Select:
        1. Create a Class
        2. Create a Interface
	3. Display Interface's Methods
        4. Display Class's Properties and Methods
        0. Quit
EOF
echo "Current directory: "
pwd
ls
    read -p "Enter selection [0-4] > "
    case "$REPLY" in
        0)
            break
            ;;
        1)
	    echo ""
	    echo "Create a new class"
            read -p "Class's name: "
	    
	    #create file
	    eval "touch $REPLY.sh"
	    FILE=$REPLY
	    read -p "Inherited class: "
	    Inherited_class=$REPLY
	    read -p "Implement interface, separated by spaces: "
	    Interfaces=$REPLY
	    printf "
#!/bin/bash

# Base class. (1)
" >> "$FILE.sh"
	    for Inherited in $Inherited_class
	    do
	    printf "
. $Inherited.sh" >> "$FILE.sh"
	    done
	    for interface in $Interfaces
	    do
	        printf "
. $interface.sh" >> "$FILE.sh"
            done

            printf "

function $FILE()
{
    # A pointer to this Class. (2)
    local base=\$FUNCNAME	# Vector	
    local this=\$1 		# vector1 
 
    # Inherited classes (optional). (3)
" >> "$FILE.sh"
	    printf "
    export \${this}_inherits=\"$Inherited_class\" # (3.1)
    # Implement interface (optional). (4)
    export \${this}_interfaces=\"$Interfaces\" # (4.1)
" >> "$FILE.sh"
	    
	    printf "
    local class=\$(eval \"echo \\$\${this}_inherits\")
    local interfaces=\$(eval \"echo \\$\${this}_interfaces\")
" >> "$FILE.sh"

	printf "
    # Inherited construction  (5)
    # eval \"\$class '\$class' \$2 \$3 \$4\"

    for property in \$(compgen -A variable \${class}_)
    do
    	export \${property/#\$class\_/\$this\_}=\$(eval \"echo \\$\${property}\")
    done
    for method in \$(compgen -A function \${class}_)
    do
    	export \${method/#\$class\_/\$this\_}=\"\${method} \${this}\"
    done

    # Declare Properties. (6)
    export \${this}_xx=\$2
    #export \${this}_y=\$3
    #export \${this}_z=\$4

    # Declare methods. (7)
    for e_method in \$(compgen -A function \${base}_)
    do
        export \${e_method/#\$base\_/\$this\_}=\"\${e_method} \${this}\"
    done
    
    for interface in \$interfaces
    do
	eval \"\$interface '\$interface'\" 
    
    	for i_property in \$(compgen -A variable \${interface}_)
    	do
	    echo \"32: Interface cannot have properties \$i_property\"
    	    exit 1
    	done
		
    	for i_method in \$(compgen -A function \${interface}_)
    	do
	    flag='f'
    	    for method in \$(compgen -A function \${class}_) 
    	    do
	    	A=\"\$(cut -d'_' -f2 <<<\"\$method\")\"
	    	B=\"\$(cut -d'_' -f2 <<<\"\$i_method\")\"
	    	if [[ \$A == \$B ]]
	    	then
		    flag='t'
	    	    break
	    	fi
	    done
	    for method in \$(compgen -A function \${base}_) 
    	    do
	    	A=\"\$(cut -d'_' -f2 <<<\"\$method\")\"
	    	B=\"\$(cut -d'_' -f2 <<<\"\$i_method\")\"
	    	if [[ \$A == \$B ]]
	    	then
		    flag='t'
	    	    break
	    	fi
	    done
	    if [[ \$flag == 'f' ]]
	    then
	        echo \"method \$i_method is not yet been implemented\"
	        exit 1
    	    fi
    	done
    done
    
    CLASS=\$class
}
 
# Human readable representation of the vector. (8)
function ${FILE}_hello()
{
    local base=\$(expr \"\$FUNCNAME\" : '\([a-zA-Z][a-zA-Z0-9]*\)')
    local this=\$1
	
    echo \"${FILE} hello world\"
}
" >> "$FILE.sh"
	vim $FILE.sh
            ;;
        2)
            echo ""
	    echo "Create a new interface"
            read -p "Interface's name: "
	    eval "touch $REPLY.sh"
	    printf "
#!/bin/bash

# Base class. (1)
function ${REPLY}()
{
    # A pointer to this Class. (2)
    local base=\$FUNCNAME      # Vector        

    local this=\$1             # vector1 

    # Declare methods. (5)
    for method in \$(compgen -A function)
    do
        export \${method/\_}=\"\${method} \${this}\"
    done

}

function ${REPLY}_hello()
{
    local base=\$(expr \"\$FUNCNAME\" : '\([a-zA-Z][a-zA-Z0-9]*\)')
    local this=\$1
    echo \"Can't call this function \$base_ \$this\"
    exit 1
}
" >> $REPLY.sh
	    vim $REPLY.sh
            ;;
        3)
            echo ""
	    echo "Show all interface's method"
            read -p "Interface's name: "
	    . $REPLY.sh
	    eval "$REPLY '$REPLY'"
	    echo ""
            for i_method in $(compgen -A function ${REPLY}_)
	    do
            	echo $i_method
            done
            ;;
	4)
	    echo ""
	    echo "Show all class's properties and methods"
            read -p "Class's name: "
	    . $REPLY.sh
	    eval "$REPLY '$REPLY'"
	    echo ""
	    
	    echo "$REPLY properties: "
	    for property in $(compgen -A variable ${REPLY}_)
	    do
	    flag1='t'
	    for e_method in $(compgen -A function ${P_CLASS}_)
    	    do
                flag='t'
		for method in $(compgen -A function ${REPLY}_) 
		do
	    	    A=$(cut -d'_' -f2 <<<"$method")
	    	    B=$(cut -d'_' -f2 <<<"$e_method")    
    		    if [[ $A == $B ]]
                    then
			flag='f'
                        break
                    fi
		done
		if [[ $flag == 't' ]]
	        then
		    if [[ "$property" == "${REPLY}_$B" ]]
            	    then
			flag1='f'
			break
			
		    fi
                fi
    	    done

	    for i_method in $(compgen -A function ${REPLY}_)
	    do
            	if [[ "$property" == "$i_method" ]]
            	then
		    flag1='f'
		    break
		fi
            done

	    if [[ $flag1 == 't' ]]
	    then
		if [[ "$property" != "${REPLY}_inherits" ]]
		then
		    if [[ "$property" != "${REPLY}_interfaces" ]]
		    then
			if [[ "$property" != "${REPLY}_" ]]
			then
			    echo $property
			fi
		    fi
		fi

	    fi
	done
	    echo ""
            echo "$REPLY methods: "
            for method in $(compgen -A function ${REPLY}_)
	    do
            	echo $method
            done
	    
            for e_method in $(compgen -A function ${P_CLASS}_)
    	    do
                flag='t'
		for method in $(compgen -A function ${REPLY}_) 
		do
	    	    A=$(cut -d'_' -f2 <<<"$method")
	    	    B=$(cut -d'_' -f2 <<<"$e_method")    
    		    if [[ $A == $B ]]
                    then
			flag='f'
                        break
                    fi
		done
		if [[ $flag == 't' ]]
	        then
		    echo "${REPLY}_$B"
                fi
    	    done


            ;;
        *)
            echo "Invalid entry."
            ;;
    esac
    echo "_____________________________"
    read -p "Enter to next"
done
echo "Program terminated."
