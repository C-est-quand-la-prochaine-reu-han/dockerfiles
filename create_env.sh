#!/bin/sh

if [ ! -f srcs/.env ]
then
	exec 3<srcs/.env.empty

	while read -r line <&3
	do
		case $line in
			"#"*)
				continue
				;;
			"")
				continue
				;;
		esac
		printf $line
		read -r var
		echo $line$var >> srcs/.env
	done

	exec 3>&-
fi
