#!/bin/bash
#
# Passowrd generator using utils.sh
#

# source from file or link
source <(curl -Ls "https://raw.githubusercontent.com/Noam-Alum/utils.sh/main/utils-min.sh")

# utils config
uc_ifc_posfix="[<g>{{ E-success }}</g> y / <r>{{ E-fail }}</r> n] : "

# Ask if user wants a password
if [ $(ifcontinue "{{ B-arrow }} Do you want a password?") -eq 0 ];then

  # Get user input
  user_input pass_len "int" "{{ B-arrow }} How long should it be? "
  user_input pass_charset "opt int str all" "{{ B-arrow }} Choose <bw>int, str or all</bw> : "

  xecho "{{ B-arrow }} Your new password: <bw><on_b>$(gen_random $pass_charset $pass_len)</bw></on_b>"
else
  xecho "{{ B-arrow }} Why not? <p>{{ E-sad }}</p>"
fi
