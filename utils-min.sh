#!/bin/bash
# utils-min.sh - A collection of functions to make scripting in bash easier.
# Written by: Noam Alum
# Documentation: https://docs.alum.sh/utils.sh/Introduction.html
set +H
declare -Ag shortcodes=(["{{ ERROR }}"]="[\e[31mERROR\e[0m]" ["{{ GOOD }}"]="[\e[32mGOOD\e[0m]" ["{{ INFO }}"]="[\e[37mINFO\e[0m]" ["{{ WARNING }}"]="[\e[33mWARNING\e[0m]" ["{{ ALERT }}"]="[\e[38;5;208mALERT\e[0m]" ["{{ NOTE }}"]="[\e[34mNOTE\e[0m]" ["{{ IMPORTANT }}"]="[\e[1mIMPORTANT\e[0m]" ["{{ SUCCESS }}"]="[\e[92mSUCCESS\e[0m]" ["{{ E-shocked }}"]="⊙▂⊙" ["{{ E-smile }}"]="ʘ‿ʘ" ["{{ E-angry }}"]="ಠ_ರೃ" ["{{ E-sad }}"]="◕︵◕" ["{{ E-nervous }}"]="⊙﹏⊙" ["{{ E-gun }}"]="▄︻̷̿┻̿═━一" ["{{ E-heart }}"]="❤" ["{{ E-star }}"]="✮" ["{{ E-music }}"]="♫" ["{{ E-moon }}"]="☾" ["{{ E-cloud }}"]="☁︎" ["{{ E-arrowright }}"]="➜" ["{{ E-arrowleft }}"]="←" ["{{ E-redo }}"]="↺" ["{{ E-sleep }}"]="ᶻz" ["{{ E-success }}"]="✔" ["{{ E-fail }}"]="✘" ["{{ BR-scissors }}"]="-ˋˏ✄┈┈┈┈" ["{{ BR-star }}"]="────⋆⋅☆⋅⋆────" ["{{ BR-specialdots }}"]="✦•┈๑⋅⋯ ⋯⋅๑┈•✦" ["{{ BR-heart }}"]="ﮩ٨ـﮩﮩ٨ـ♡ﮩ٨ـﮩﮩ٨ـ" ["{{ BR-bear }}"]="━━━━━━ʕ•㉨•ʔ━━━━━━━" ["{{ BR-music }}"]="01:43 ━━━━●───── 03:50" ["{{ B-dot }}"]="•" ["{{ B-arrow }}"]="➣" ["{{ B-diamond }}"]="◈")
declare -Ag tags=(["<b>"]="\\e[30m" ["<r>"]="\\e[31m" ["<g>"]="\\e[32m" ["<y>"]="\\e[33m" ["<bl>"]="\\e[34m" ["<p>"]="\\e[35m" ["<c>"]="\\e[36m" ["<w>"]="\\e[37m" ["<bb>"]="\\e[1;30m" ["<br>"]="\\e[1;31m" ["<bg>"]="\\e[1;32m" ["<by>"]="\\e[1;33m" ["<bbl>"]="\\e[1;34m" ["<bp>"]="\\e[1;35m" ["<bc>"]="\\e[1;36m" ["<bw>"]="\\e[1;37m" ["<on_b>"]="\\e[40m" ["<on_r>"]="\\e[41m" ["<on_g>"]="\\e[42m" ["<on_y>"]="\\e[43m" ["<on_bl>"]="\\e[44m" ["<on_p>"]="\\e[45m" ["<on_c>"]="\\e[46m" ["<on_w>"]="\\e[47m" ["<bib>"]="\\e[1;90m" ["<bir>"]="\\e[1;91m" ["<big>"]="\\e[1;92m" ["<biy>"]="\\e[1;93m" ["<bibl>"]="\\e[1;94m" ["<bip>"]="\\e[1;95m" ["<bic>"]="\\e[1;96m" ["<biw>"]="\\e[1;97m" ["<on_ib>"]="\\e[0;100m" ["<on_ir>"]="\\e[0;101m" ["<on_ig>"]="\\e[0;102m" ["<on_iy>"]="\\e[0;103m" ["<on_ibl>"]="\\e[0;104m" ["<on_ip>"]="\\e[0;105m" ["<on_ic>"]="\\e[0;106m" ["<on_iw>"]="\\e[0;107m")
function xecho {
local content="$*"
for tag in "${!tags[@]}"; do
content="${content//"$tag"/"${tags[$tag]}"}"
done
content="$(echo "$content" | sed -E 's#</.{1,5}>#\\e[0m#g')"
for sc in "${!shortcodes[@]}"; do
content="${content//"$sc"/"${shortcodes[$sc]}"}"
done
echo -e "$content"
}
function ifcontinue {
test -z "$uc_ifc_posfix" && uc_ifc_posfix="[<big>yes</big>/<bir>no</bir>] : "
ifc_promt="$(xecho "$1 $uc_ifc_posfix")"
ifc_ans=""
until [[ "$ifc_ans" =~ (yes|no|y|n) ]]; do
read -p "$ifc_promt" ifc_ans
ifc_ans="$(echo "$ifc_ans" | tr -s '[A-Z]' '[a-z]')"
done
if [[ "$ifc_ans" =~ (yes|y) ]]; then
echo "0"
return 0
else
echo "1"
return 1
fi
}
function user_input {
ui_variable="$1"
ui_option="$2"
shift 2
ui_promt="$(xecho "$*")"
case $ui_option in
mail)
ui_arg="! -z \"\${!ui_variable}\" && \"\${!ui_variable}\" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
;;
int*)
ui_min="$(awk {'print $2'} <<< "$ui_option")"
ui_max="$(awk {'print $3'} <<< "$ui_option")"
ui_arg="! -z \"\${!ui_variable}\" && \"\${!ui_variable}\" =~ ^[0-9]+$ && \${!ui_variable} -ge $ui_min && \${!ui_variable} -le $ui_max"
;;
opt*)
options="^($(tr -s ' ' '|' <<< $(cut -d' ' -f2- <<< "$ui_option")))$"
ui_arg="! -z \"\${!ui_variable}\" && \"\${!ui_variable}\" =~ $options"
;;
str)
ui_arg="! -z \"\${!ui_variable}\" && \"\${!ui_variable}\" =~ ^[a-zA-Z]+$"
;;
txt)
ui_arg="! -z \"\${!ui_variable}\""
;;
esac
until eval "[[ $ui_arg ]]"; do
read -p "$ui_promt" $ui_variable
done
}
function gen_random {
test -z "$1" && local GR_OPT="all" || local GR_OPT="$1"
test -z "$2" && local uc_gr_len="12" || local uc_gr_len="$2"
case $GR_OPT in
all)
local CHARSET="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz,'\"!@#$%^&*()-_=+|[]{};:/?.>"
;;
str)
local CHARSET="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
;;
int)
local CHARSET="0123456789"
;;
*)
echo "Error while using \"$FUNCNAME\" function, not a valid option ($GR_OPT), refer to \"https://docs.alum.sh/utils.sh/functions/gen_random.html\" for more information." 2>&1
;;
esac
readonly CHARSET
if [ -z "${uc_gr_len//[0-9]}" ]; then
local RES="$(tr -dc "$CHARSET" < /dev/urandom | head -c "$uc_gr_len")"
else
echo "Error while using \"$FUNCNAME\" function, length not an int ($uc_gr_len), refer to \"https://docs.alum.sh/utils.sh/functions/gen_random.html\" for more information." 2>&1
fi

if [ ! -z "$RES" ]; then
echo "$RES"
return 0
else
echo "Could not get results while using \"$FUNCNAME\" function, refer to \"https://docs.alum.sh/utils.sh/functions/gen_random.html\" for more information." 2>&1
fi
}
function run {
rn_ec=$1
rn_verbal="$2"
rn_cmd="$3"
test -z "$uc_rn_inf_msg" && uc_rn_inf_msg="{{ INFO }} Executed <on_b><bw> {[ rn_cmd ]} </on_b></bw> successfully <big>{{ E-success }}</big>."
test -z "$uc_rn_err_msg" && uc_rn_err_msg="{{ ERROR }} Error while executing <on_b><bw> {[ rn_cmd ]} </on_b></bw> {{ E-angry }}\n{{ BR-specialdots }}\n  <bw>Error:</bw>\n{{ BR-specialdots }}\n<on_ir><bw> {[ rn_err ]} </bw></on_ir>\n{{ BR-specialdots }}"
rn_err="$(eval "$rn_cmd 2>&1")"
rn_res="$?"
test $(wc -l <<< "$rn_cmd") -gt 1 && rn_cmd="$(head -n 1 <<< "$rn_cmd") ... etc"
uc_rn_after_err_msg="${uc_rn_err_msg//"{[ rn_err ]}"/"$rn_err"}"
uc_rn_after_err_msg="${uc_rn_after_err_msg//"{[ rn_cmd ]}"/"$rn_cmd"}"
uc_rn_after_inf_msg="${uc_rn_inf_msg//"{[ rn_cmd ]}"/"$rn_cmd"}"
if [ $rn_res -ne $rn_ec ]; then
xecho "$uc_rn_after_err_msg"
return 1
elif [ "$rn_verbal" == "info" ]; then
xecho "$uc_rn_after_inf_msg"
return 0
fi
}