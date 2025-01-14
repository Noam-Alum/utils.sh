#!/bin/bash

# Source utils.sh
source <(curl -Ls "https://raw.githubusercontent.com/Noam-Alum/utils.sh/main/utils-min.sh")

# uc_ variables
uc_rn_inf_msg="{{ B-dot }} Downloaded successfully! <big>{{ E-smile }}</big>."
uc_rn_err_msg="{{ B-dot }} <on_ir><bw>Error while downloading file:</bw></on_ir>\n{{ BR-star }}\n{[ rn_err ]}"

user_input url txt "{{ B-dot }} URL : "
user_input dir txt "{{ B-dot }} File name : "

# Check if user wants to download
if [ $(ifcontinue "{{ B-dot }} Are you sure you want to continue?" ) -eq 0 ]; then
  http_code=$(curl -o /dev/null -w '%{http_code}' -Ls "$url")
  if [[ $http_code =~ (3|2) ]]; then
    xecho "{{ B-dot }} Dowbloading file from <y>{{ E-gun }}</y> - <bw>$url</bw>"
    run 0 "info" "curl -o \"$dir\" \"$url\""
  else
    xecho "{{ B-dot }} Error HTTP code returned <on_ir><bw>$http_code</bw></on_ir>."
  fi
else
  xecho "{{ B-dot }} Ok, bye <bip>{{ E-nervous }}</bip>."
fi
