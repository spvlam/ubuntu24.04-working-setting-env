#!/bin/bash

if which postman;then
	echo "Postman has been installed"
else
	curl -o- "https://dl-cli.pstmn.io/install/linux64.sh" | sh
fi;

postman --version
