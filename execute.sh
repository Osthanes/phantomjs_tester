#!/bin/bash

#********************************************************************************
# Copyright 2014 IBM
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#********************************************************************************

#############
# Colors    #
#############
export green='\e[0;32m'
export red='\e[0;31m'
export label_color='\e[0;33m'
export no_color='\e[0m' # No Color

##################################################
# Simple function to only run command if DEBUG=1 # 
### ###############################################
debugme() {
  [[ $DEBUG = 1 ]] && "$@" || :
}

set +e
set +x 

cmd_choice=$CMD_CHOICE

function execute { 
    eval $CMD_CHOICE
    RESULT=$?
    
    if [ $RESULT -ne 0 ] || [ $PY_RES -ne 0 ]; then
        exit 1
    fi
}

if [[ $cmd_choice == "npm test" ]] || [[ $cmd_choice == "grunt test" ]] || [[ $cmd_choice == "grunt" ]]; then
    npm install
    execute
fi
if [[ $cmd_choice == "ant test" ]] || [[ $cmd_choice == "mvn test" ]]; then
    echo "Installing phantomjs..."
    npm install -g phantomjs
    execute
fi
if [[ $cmd_choice == "custom" ]]; then
    custom_cmd
fi