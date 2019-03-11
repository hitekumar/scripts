#!/bin/bash

GERRIT_LIST="./gerrit_list"

cherry-pick-gerrit-topic()
{
    TOPIC=$1
    LOG_FILE=$2
    if [ -f "${LOG_FILE}" ];then
        echo "#Below gerrits will be picked" > "${LOG_FILE}"
    fi

    ssh -p 29418 gerrit.url.com  gerrit query --format=text --current-patch-set topic:${TOPIC} > ${GERRIT_LIST}

    while read line
    do
       if [[ $line == *"project:"* ]]; then
           project=`echo "${line}" | cut -d ':' -f2 | tr -d ' '`
       fi

       if [[ $line == *"ref:"* ]]; then
           ref=`echo "${line}" | cut -d ':' -f2 | tr -d ' ' | cut -d '/' -f4-`
           echo $project
           echo $ref
           echo "./repo download --verify ${project} ${ref}" >> ${LOG_FILE}
           ./repo download --verify ${project} ${ref}
       fi

    done < ${GERRIT_LIST}
    rm -f ${GERRIT_LIST}
}

cherry-pick-gerrit-topic  "TOPIC" "TOPIC.log"

