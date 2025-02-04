#!/bin/bash
# utils.sh - A collection of functions to make scripting in bash easier.
#
# Written by: Noam Alum
# Documentation: https://docs.alum.sh/utils.sh/Introduction.html
# 

# Settings
set +H

# Variables

## Define shortcodes and tags
declare -Ag shortcodes=(
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

declare -Ag tags=(
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

# Utils
# 
# You can place **uc_** variables in the head of your script to configure utils functions for your liking.
# Each function description includes its **uc_** variables.
#
# | **uc_ variable** | **function** | **description**                       |
# |------------------|--------------|---------------------------------------|
# | uc_ifc_posfix    | ifcontinue   | Change default posfix (*[yes/no]*).   |
# | uc_gr_len        | gen_random   | Change default length (*12*).         |
# | uc_rn_err_msg    | run          | Change the structure of the error msg.|
# | uc_rn_inf_msg    | run          | Change the structure of the info msg. | 
#
# If a uc_ variable has dynamically changing parts, you'd have to use **placeholders**, placeholders are
# called using {[ name ]}:
#
# | placeholder    | Description                                                            |
# | -------------- | ---------------------------------------------------------------------- |
# | `{[ rn_cmd ]}` | The command executed by the run function.                              |
# | `{[ rn_err ]}` | The error returned after executing a given command with run            |
#
## xecho - Extended echo
# :  **xecho** is a utility designed to facilitate color usage output,
# :  offering a variety of shortcodes for easy integration into your text.
# :  
# :  ## ShortCodes:
# :  | ShortCode            | Result                          |
# :  | -------------------- | ------------------------------- |
# :  | **Blocks:**          |                                 |
# :  | {{ ERROR }}          | [ERROR]  (text red)             |
# :  | {{ GOOD }}           | [GOOD] (text green)             |
# :  | {{ INFO }}           | [INFO] (text grey)              |
# :  | {{ WARNING }}        | [WARNING] (text yellow)         |
# :  | {{ ALERT }}          | [ALERT] (text orange)           |
# :  | {{ NOTE }}           | [NOTE] (text blue)              |
# :  | {{ IMPORTANT }}      | [IMPORTANT] (text bold)         |
# :  | {{ SUCCESS }}        | [SUCCESS] (text light green)    |
# :  | **Faces:**           |                                 |
# :  | {{ E-shocked }}      | ⊙▂⊙                             |
# :  | {{ E-smile }}        | ʘ‿ʘ                             |
# :  | {{ E-angry }}        | ಠ_ರೃ                             |
# :  | {{ E-sad }}          | ◕︵◕                             |
# :  | {{ E-nervous }}      | ⊙﹏⊙                             |
# :  | **Other:**           |                                 |
# :  | {{ E-gun }}          | ▄︻̷̿┻̿═━一                       |
# :  | {{ E-heart }}        | ❤                               |
# :  | {{ E-star }}         | ✮                               |
# :  | {{ E-music }}        | ♫                               |
# :  | {{ E-moon }}         | ☾                               |
# :  | {{ E-cloud }}        | ☁︎                               |
# :  | {{ E-arrowright }}   | ➜                               |
# :  | {{ E-arrowleft }}    | ←                               |
# :  | {{ E-redo }}         | ↺                               |
# :  | {{ E-sleep }}        | ᶻz                              |
# :  | {{ E-success }}      | ✔                               |
# :  | {{ E-fail }}         | ✘                               |
# :  | **Page breaks:**     |                                 |
# :  | {{ BR-scissors }}    | -ˋˏ✄┈┈┈┈                         |
# :  | {{ BR-star }}        | ────⋆⋅☆⋅⋆────                   |
# :  | {{ BR-specialdots }} | ✦•┈๑⋅⋯ ⋯⋅๑┈•✦                   |
# :  | {{ BR-heart }}       | ﮩ٨ـﮩﮩ٨ـ♡ﮩ٨ـﮩﮩ٨ـ                 |
# :  | {{ BR-bear }}        | ━━━━━━ʕ•㉨•ʔ━━━━━━━              |
# :  | {{ BR-music }}       | 01:43 ━━━━●───── 03:50          |
# :  | **Text bullets:**    |                                 |
# :  | {{ B-dot }}          | •                               |
# :  | {{ B-arrow }}        | ➣                               |
# :  | {{ B-diamond }}       | ◈                               |
# :  
# :  ## Tags:
# :  | Color                                 | Tag        | Example                 |
# :  |---------------------------------------|------------|-------------------------|
# :  | Black                                 | `<b>`      | `<b>word</b>`           |
# :  | Red                                   | `<r>`      | `<r>word</r>`           |
# :  | Green                                 | `<g>`      | `<g>word</g>`           |
# :  | Yellow                                | `<y>`      | `<y>word</y>`           |
# :  | Blue                                  | `<bl>`     | `<bl>word</bl>`         |
# :  | Purple                                | `<p>`      | `<p>word</p>`           |
# :  | Cyan                                  | `<c>`      | `<c>word</c>`           |
# :  | White                                 | `<w>`      | `<w>word</w>`           |
# :  | **Bold Colors:**                      |            |                         |
# :  | Bold Black                            | `<bb>`     | `<bb>word</bb>`         |
# :  | Bold Red                              | `<br>`     | `<br>word</br>`         |
# :  | Bold Green                            | `<bg>`     | `<bg>word</bg>`         |
# :  | Bold Yellow                           | `<by>`     | `<by>word</by>`         |
# :  | Bold Blue                             | `<bbl>`    | `<bbl>word</bbl>`       |
# :  | Bold Purple                           | `<bp>`     | `<bp>word</bp>`         |
# :  | Bold Cyan                             | `<bc>`     | `<bc>word</bc>`         |
# :  | Bold White                            | `<bw>`     | `<bw>word</bw>`         |
# :  | **BG Colors:**                        |            |                         |
# :  | Black BG                              | `<on_b>`   | `<on_b>word</on_b>`     |
# :  | Red BG                                | `<on_r>`   | `<on_r>word</on_r>`     |
# :  | Green BG                              | `<on_g>`   | `<on_g>word</on_g>`     |
# :  | Yellow BG                             | `<on_y>`   | `<on_y>word</on_y>`     |
# :  | Blue BG                               | `<on_bl>`  | `<on_bl>word</on_bl>`   |
# :  | Purple BG                             | `<on_p>`   | `<on_p>word</on_p>`     |
# :  | Cyan BG                               | `<on_c>`   | `<on_c>word</on_c>`     |
# :  | White BG                              | `<on_w>`   | `<on_w>word</on_w>`     |
# :  | **Bold High Intensity Colors:**       |            |                         |
# :  | Bold High Intensity Black             | `<bib>`    | `<bib>word</bib>`       |
# :  | Bold High Intensity Red               | `<bir>`    | `<bir>word</bir>`       |
# :  | Bold High Intensity Green             | `<big>`    | `<big>word</big>`       |
# :  | Bold High Intensity Yellow            | `<biy>`    | `<biy>word</biy>`       |
# :  | Bold High Intensity Blue              | `<bibl>`   | `<bibl>word</bibl>`     |
# :  | Bold High Intensity Purple            | `<bip>`    | `<bip>word</bip>`       |
# :  | Bold High Intensity Cyan              | `<bic>`    | `<bic>word</bic>`       |
# :  | Bold High Intensity White             | `<biw>`    | `<biw>word</biw>`       |
# :  | **High Intensity BG Colors:**         |            |                         |
# :  | High Intensity Black BG               | `<on_ib>`  | `<on_ib>word</on_ib>`   |
# :  | High Intensity Red BG                 | `<on_ir>`  | `<on_ir>word</on_ir>`   |
# :  | High Intensity Green BG               | `<on_ig>`  | `<on_ig>word</on_ig>`   |
# :  | High Intensity Yellow BG              | `<on_iy>`  | `<on_iy>word</on_iy>`   |
# :  | High Intensity Blue BG                | `<on_ibl>` | `<on_ibl>word</on_ibl>` |
# :  | High Intensity Purple BG              | `<on_ip>`  | `<on_ip>word</on_ip>`   |
# :  | High Intensity Cyan BG                | `<on_ic>`  | `<on_ic>word</on_ic>`   |
# :  | High Intensity White BG               | `<on_iw>`  | `<on_iw>word</on_iw>`   |
# :
# : **For example:**
# : ```bash
# : xecho "<on_ic><bir>I love bash </bir></on_ic><on_ir><bic> {{ E-heart }} </bic></on_ir>"
# : ```
# : **Results:**
# : [CYAN & RED BG]I love bash [CYAN & RED BG][RED & CYAN BG] ❤ [RED & CYAN BG]

function xecho {
  local content="$*"

  # Replace tags
  for tag in "${!tags[@]}"; do
    content="${content//"$tag"/"${tags[$tag]}"}"
  done
  content="$(echo "$content" | sed -E 's#</.{1,5}>#\\e[0m#g')"

  # Replace shortcodes
  for sc in "${!shortcodes[@]}"; do
    content="${content//"$sc"/"${shortcodes[$sc]}"}"
  done

  echo -e "$content"
}

## ifcontinue
# : **ifcontinue** is a function meant to return binary response to a yes-or-no question.
# :
# : **For example:**
# : ```bash
# : if [ $(ifcontinue "{{ B-dot }} Do <on_bl>you</on_bl> want to go <bb>do something</bb>?") -eq 0 ]; then
# :   xecho "Good - <g>{{ E-smile }}</g>"
# : else
# :   xecho "Bad - <g>{{ E-sad }}</g>"
# : fi
# : ```
# :
# : **Results:**
# : • Do you want to go do something? [yes/no] : yes
# : Good - ʘ‿ʘ
# : 
# : ## uc variables:
# : 
# : `uc_ifc_posfix` - Change default posfix (*[yes/no]*).
# :   For example:
# :   ```bash
# :   uc_ifc_posfix="<bl>yes</bl>|<bir>no</bir> - "
# :   ```
# :   Would change "[yes/no]" to "yes|no -".
# :

function ifcontinue {
  # uc variables
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

## user_input
# : **user_input** is a function meant to take user input in and save it as a variable
# : in the best way possible.
# : 
# : ## Types
# : 
# : - **mail:** validates a mail address.
# :      ```bash
# :      user_input mail "mail" "What is your mail address?"
# :      ```
# : - **int:** only accepts integers, you can choose a range, if you dont want just use plane `int`.
# :      ```bash
# :      user_input age "int 1 100" "What is your age?"
# :      # OR
# :      user_input age "int" "What is your age?"
# :      ```
# : - **str:** accepts only charecters.
# :      ```bash
# :      user_input string "str" "What is your name?"
# :      ```
# : - **opt:** accepts only selection of inputs given after opt.
# :      ``` bash➣ What protocol do you want to use? [tcp/udp] : udpoth integers and charecters.
# :      ``` bash
# :      user_input username "txt" "What is your username?"
# :      ```
# :
# : **For example:**
# : ```bash
# : user_input protocol "opt tcp udp" "<g>{{ B-arrow }}</g> What protocol do you want to use? [<bl>tcp</bl>/<r>udp</r>] : "
# : ```
# : **Result:**
# : ➣ What protocol do you want to use? [tcp/udp] : udp
# : (Now a variable named "protocol" was created with the value of "udp")

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

## gen_random
# : Generate random data.
# :
# : Options:
# :   - int | Only use numbers.
# :   - str | Only use alphabetic characters.
# :   - all | Use anything.
# :
# : **For example:**
# : ```bash
# : gen_random int 14
# : ```
# : **Would return:**<br>
# : 36261766974132
# : 
# : ## uc variables:
# : 
# : `uc_gr_len` - Change default length (*12*).
# :   For example:
# :   ```bash
# :   uc_gr_len=8
# :   ```
# :

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

## run - run commands in an informative way
# :
# : The **run** function is intended to execute commands with both informative clarity
# : and stylish presentation.
# :
# : **Usage:**
# : ```bash
# : run <wanted-exit-code> "<info/notinfo>" "<cmd>"
# : ```
# : - `<wanted-exit-code>`: An integer, usually 0.
# : - `<info/notinfo>`: Wheter or not to inform if a commmand has been executed.
# :   ```bash
# :   run 0 "info" "cat exists.txt"
# :   ```
# :   Would return:<br>
# :   [INFO] Executed  cat exists.txt  successfully ✔.<br>
# :   If I used *noinfo* nothig would have been returned.
# : - `<cmd>`: The command you want to execute.
# :
# : **For example:**
# : ```
# : run 0 "info" cat does-not-exists.txt
# : ```
# : Would return:
# :
# : [ERROR] Error while executing  cat does-not-exists.txt  ಠ_ರೃ
# : ✦•┈๑⋅⋯ ⋯⋅๑┈•✦
# :    Error:
# : ✦•┈๑⋅⋯ ⋯⋅๑┈•✦
# : cat: does-not-exists.txt: No such file or directory
# : ✦•┈๑⋅⋯ ⋯⋅๑┈•✦
# :
# : ## uc_ variables
# :
# : ### Placeholders
# :
# : | Placeholder    | Description                                                            |
# : | -------------- | ---------------------------------------------------------------------- |
# : | `{[ rn_cmd ]}` | The command executed by the run function.                              |
# : | `{[ rn_err ]}` | The error returned after executing a given command with run            |
# :
# : - **uc_rn_inf_msg:** Change the info message stracture.<br>
# :   ```bash
# :   uc_rn_inf_msg="{{ B-arrow }} Smootly executed {[ rn_cmd ]} {{ E-smile }}"
# :   ```
# :   Now when info messages are used they would look like so:
# :   ```txt
# :   ➣ Smoothly executed {[ rn_cmd ]} ʘ‿ʘ
# :   ```
# :   {[ rn_cmd ]} being the command you've executed.
# : 
# : - **uc_rn_err_msg:** Change the error message stracture.<br>
# :   ```bash
# :   uc_rn_err_msg="{{ B-arrow }} Ops! error while executing {[ rn_cmd ]} {{ E-sad }}\n{[ rn_err ]}"
# :   ```
# :   Now when error messages are used they would look like so:
# :   ```txt
# :   ➣ Ops! error while executing {[ rn_cmd ]} ◕︵◕
# :   {[ rn_err ]}
# :   ```
# :   {[ rn_cmd ]} being the command you've executed, and {[ rn_err ]} being the error returned.

function run {
  rn_ec=$1
  rn_verbal="$2"
  rn_cmd="$3"

  test -z "$uc_rn_inf_msg" && uc_rn_inf_msg="{{ INFO }} Executed <on_b><bw> {[ rn_cmd ]} </on_b></bw> successfully <big>{{ E-success }}</big>."
  test -z "$uc_rn_err_msg" && uc_rn_err_msg="{{ ERROR }} Error while executing <on_b><bw> {[ rn_cmd ]} </on_b></bw> {{ E-angry }}\n{{ BR-specialdots }}\n    <bw>Error:</bw>\n{{ BR-specialdots }}\n<on_ir><bw> {[ rn_err ]} </bw></on_ir>\n{{ BR-specialdots }}"

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
