#!/bin/bash

_Help() {
    cat << 'EOF'
Commands may be abbreviated.  Commands are:

!		debug		mdir		sendport	site
$		dir		mget		put		size
account		disconnect	mkdir		pwd		status
append		exit		mls		quit		struct
ascii		form		mode		quote		system
bell		get		modtime		recv		sunique
EOF
}

_Import() {
    echo ">>>> [Import] <<<<"
}

while true
do
    echo -n 'ftp> '
    read CMD

    case $CMD in 
        'help')       _Help ;;
        'import')   _Import ;;
        'quit'|'bye') break ;;
        *) echo "?Invalid command" ;;
    esac
done
