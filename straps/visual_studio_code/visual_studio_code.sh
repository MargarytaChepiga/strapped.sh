#!/bin/bash
strapped_visual_studio_code_before () { 
    if ! code -v > /dev/null; then echo "💻 visual studio code is missing" && exit; fi 
}

strapped_visual_studio_code () {
    local ext
    local ext_count

    ext_count=$(jq -r '.visual_studio_code.extensions | length' <<< "${1}" )
    
    for (( i=0; i <ext_count; i++ )); do
        ext=$(jq -r ".visual_studio_code.extensions[${i}].name" <<< "${1}")
        echo "💻 adding extension ${ext}"
        code --install-extension "${ext}"
    done
}

strapped_visual_studio_code_after () { 
    return
}


