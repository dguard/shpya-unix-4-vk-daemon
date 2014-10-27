#!/usr/bin/env bash

if [[ ${1} == ""  ]]
then
    echo "Usage: ./vk-daemon.sh <user_id> [tmp-dir=/tmp/vk-daemon]"
    exit
fi

if [[ ${2} == ""  ]]
then
    DIR=/tmp/vk-daemon
else
    DIR=${2}
fi
mkdir -p ${DIR}

JSON_FILE=${DIR}/user_${1}_info.json
STATUS_FILE=${DIR}/user_${1}_status

wget --output-document ${JSON_FILE} "https://api.vk.com/method/users.get.json?uid=${1}&fields=online" 2>/dev/null

function get_param(){ # parse json
    param=$(cat ${JSON_FILE} | sed -re "s|.+(\"${1}\".+).+]}|\1|g" | awk -F "," '{ print $1 }' | awk -F ":" '{ print $2 }' | sed -e 's#"##g' )
}

get_param "first_name"
first_name=${param}

get_param "last_name"
last_name=${param}

get_param "online"
online=${param}

if [ ! -f ${STATUS_FILE}  ]; then
    touch ${STATUS_FILE}
    status=-1
else
    status=$(cat ${STATUS_FILE})
fi

if [[ ! ${online} -eq ${status} ]]; then
    if [[ ${online} -eq 0 ]]; then
        notify-send "Вконтакте" "Пользователь ${first_name} ${last_name} не в сети" -i gtk-info
    fi

    if [[ ${online} -eq 1 ]]; then
        notify-send "Вконтакте" "Пользователь ${first_name} ${last_name} появился Вконтакте " -i gtk-info
    fi
    echo ${online} > ${STATUS_FILE}
fi
