#!/bin/bash
set -e
strapped_git_before () { 
    if ! git --version > /dev/null; then echo "💾 git is missing" && exit; fi 
}

strapped_git () {

    local count
    local repo
    local folder
    
    count=$(yq read "${1}" -j | jq -r '.git | length')

    for i in $(seq 1 "${count}"); do
        repo=$(yq read "${1}" -j | jq -r ".git[${i}-1].repo")
        folder=$(yq read "${1}" -j | jq -r ".git[${i}-1].folder")
        echo "💾 cloning ${repo} into ${folder}"
        if [ ! -d "${folder}" ] ; then git clone "${repo}" "${folder}"; fi
    done
}

strapped_git_after () { 
    return
}
