#!/bin/bash
set +H
function xecho {
  local content="$*"
  declare -A shortcodes=(
    ["{{ ERROR }}"]="[\\e[31mERROR\\e[0m]"
    ["{{ GOOD }}"]="[\\e[32mGOOD\\e[0m]"
    ["{{ INFO }}"]="[\\e[37mINFO\\e[0m]"
    ["{{ WARNING }}"]="[\\e[33mWARNING\\e[0m]"
    ["{{ ALERT }}"]="[\\e[38;5;208mALERT\\e[0m]"
    ["{{ NOTE }}"]="[\\e[34mNOTE\\e[0m]"
    ["{{ IMPORTANT }}"]="[\\e[1mIMPORTANT\\e[0m]"
    ["{{ SUCCESS }}"]="[\\e[92mSUCCESS\\e[0m]"
    ["{{ E-shocked }}"]="⊙▂⊙"
    ["{{ E-smile }}"]="ʘ‿ʘ"
    ["{{ E-angry }}"]="ಠ_ರೃ"
    ["{{ E-sad }}"]="◕︵◕"
    ["{{ E-nervous }}"]="⊙﹏⊙"
    ["{{ E-gun }}"]="▄︻̷̿┻̿═━一"
    ["{{ E-heart }}"]="❤"
    ["{{ E-star }}"]="✮"
    ["{{ E-music }}"]="♫"
    ["{{ E-moon }}"]="☾"
    ["{{ E-cloud }}"]="☁︎"
    ["{{ E-arrowright }}"]="➜"
    ["{{ E-arrowleft }}"]="←"
    ["{{ E-redo }}"]="↺"
    ["{{ E-sleep }}"]="ᶻz"
    ["{{ E-success }}"]="✔"
    ["{{ E-fail }}"]="✘"
    ["{{ BR-scissors }}"]="-ˋˏ✄┈┈┈┈"
    ["{{ BR-star }}"]="────⋆⋅☆⋅⋆────"
    ["{{ BR-specialdots }}"]="✦•┈๑⋅⋯ ⋯⋅๑┈•✦"
    ["{{ BR-heart }}"]="ﮩ٨ـﮩﮩ٨ـ♡ﮩ٨ـﮩﮩ٨ـ"
    ["{{ BR-bear }}"]="━━━━━━ʕ•㉨•ʔ━━━━━━━"
    ["{{ BR-music }}"]="01:43 ━━━━●───── 03:50"
    ["{{ B-dot }}"]="•"
    ["{{ B-arrow }}"]="➣"
    ["{{ B-diamond }}"]="◈"
  )
  declare -A tags=(
    ["<b>"]="\\e[30m"
    ["<r>"]="\\e[31m"
    ["<g>"]="\\e[32m"
    ["<y>"]="\\e[33m"
    ["<bl>"]="\\e[34m"
    ["<p>"]="\\e[35m"
    ["<c>"]="\\e[36m"
    ["<w>"]="\\e[37m"
    ["<bb>"]="\\e[1;30m"
    ["<br>"]="\\e[1;31m"
    ["<bg>"]="\\e[1;32m"
    ["<by>"]="\\e[1;33m"
    ["<bbl>"]="\\e[1;34m"
    ["<bp>"]="\\e[1;35m"
    ["<bc>"]="\\e[1;36m"
    ["<bw>"]="\\e[1;37m"
    ["<on_b>"]="\\e[40m"
    ["<on_r>"]="\\e[41m"
    ["<on_g>"]="\\e[42m"
    ["<on_y>"]="\\e[43m"
    ["<on_bl>"]="\\e[44m"
    ["<on_p>"]="\\e[45m"
    ["<on_c>"]="\\e[46m"
    ["<on_w>"]="\\e[47m"
    ["<bib>"]="\\e[1;90m"
    ["<bir>"]="\\e[1;91m"
    ["<big>"]="\\e[1;92m"
    ["<biy>"]="\\e[1;93m"
    ["<bibl>"]="\\e[1;94m"
    ["<bip>"]="\\e[1;95m"
    ["<bic>"]="\\e[1;96m"
    ["<biw>"]="\\e[1;97m"
    ["<on_ib>"]="\\e[0;100m"
    ["<on_ir>"]="\\e[0;101m"
    ["<on_ig>"]="\\e[0;102m"
    ["<on_iy>"]="\\e[0;103m"
    ["<on_ibl>"]="\\e[0;104m"
    ["<on_ip>"]="\\e[0;105m"
    ["<on_ic>"]="\\e[0;106m"
    ["<on_iw>"]="\\e[0;107m"
  )
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
    ui_arg="! -z \"\${!ui_variable}\" && \"\${!ui_variable}\" =~ ^[0-9]+$ $(test ! -z $ui_min && test ! -z $ui_max && echo "&& \${!ui_variable} -ge $ui_min && \${!ui_variable} -le $ui_max")"
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
gen_random() {
  test -n "$uc_gr_len" && uc_gr_len=12
  gr_opt="$1"
  if [[ "$gr_opt" == "all" ]]; then
    charset="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz,'\"!@#$%^&*()-_=+|[]{};:/?.>"
  else
    if [[ "$gr_opt" == "str" ]]; then
      charset="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    fi
    if [[ "$gr_opt" == "int" ]]; then
      charset="0123456789"
    fi
  fi
  tr -dc "$charset" < /dev/urandom | head -c "$uc_gr_len"
}
function parser {
  local pr_mode="$1" 
  case $pr_mode in
    l)
      case $2 in
        c)
          local pr_line_column="$3"
          eval awk {\'print \$$pr_line_column\'}
          ;;
        b)
          local pr_line_fw="$3"
          local pr_line_sw="$4"
          awk -v start="$pr_line_fw" -v end="$pr_line_sw" '$0 ~ start {flag=1; next} $0 ~ end {flag=0} flag'
          ;;
      esac
      ;;
    b)
      case $2 in
        n)
          local pr_line_number="$3"
          awk "NR == ${pr_line_number}"
          ;;
      esac
      ;;
  esac
}
function run {
  rn_ec=$1
  rn_verbal="$2"
  rn_cmd="$3"
  test -z "$uc_rn_inf_msg" && uc_rn_inf_msg="{{ INFO }} Executed <on_b><bw> {[ rn_cmd ]} </on_b></bw> successfully <big>{{ E-success }}</big>."
  test -z "$uc_rn_err_msg" && uc_rn_err_msg="{{ ERROR }} Error while executing <on_b><bw> {[ rn_cmd ]} </on_b></bw> {{ E-angry }}\n{{ BR-specialdots }}\n    <bw>Error:</bw>\n{{ BR-specialdots }}\n<on_ir><bw> {[ rn_err ]} </bw></on_ir>\n{{ BR-specialdots }}"
  rn_err="$(eval "$rn_cmd 2>&1")"
  rn_res="$?"
  test $(wc -l <<< "$rn_cmd") -gt 1 && rn_cmd="$(parser b n 1 <<< "$rn_cmd") ... etc"
  uc_rn_err_msg="${uc_rn_err_msg//"{[ rn_err ]}"/"$rn_err"}"
  uc_rn_err_msg="${uc_rn_err_msg//"{[ rn_cmd ]}"/"$rn_cmd"}"
  uc_rn_inf_msg="${uc_rn_inf_msg//"{[ rn_cmd ]}"/"$rn_cmd"}"
  if [ $rn_res -ne $rn_ec ]; then
    xecho "$uc_rn_err_msg"
  elif [ "$rn_verbal" == "info" ]; then
    xecho "$uc_rn_inf_msg"
  fi
}
function easy_curl {
  ec_url="$3"
  curl_v="$(curl -V | grep -o 'curl [0-9.]*' | cut -d' ' -f2 | tr -d '.')"
  case $1 in
    p)
      case $2 in
        type)
          curl --max-time 3 -s -I -o /dev/null -w "%{content_type}" "$ec_url"
          ;;
        errmsg)
          if [[ $curl_v -ge 7750 ]]; then
            curl --max-time 3 -s -I -o /dev/null -w "%{errormsg}" "$ec_url"
          else
            "curl version does not support this feature (added in 7.75.0)."
          fi
          ;;
        ec)
          if [[ $curl_v -ge 7750 ]]; then
            curl --max-time 3 -s -I -o /dev/null -w "%{exitcode}" "$ec_url"
          else
            curl --max-time 3 -s -I -o /dev/null "$ec_url"
            echo "$?"
          fi
          ;;
        hc)
          curl --max-time 3 -s -I -o /dev/null -w "%{http_code}" "$ec_url"
          ;;
      esac
      ;;
  esac
}
