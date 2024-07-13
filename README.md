# Utils.sh

![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)


A collection of functions to make scripting in bash easier.<br>
You can place **uc_** variables in the head of your script to configure utils functions for your liking.

### uc_ variables

| **uc_ variable** | **function** | **description**                     |
|------------------|--------------|-------------------------------------|
| `uc_ifc_posfix`  | ifcontinue   | Change default posfix (*[yes/no]*). |
| `uc_gr_len`      | gen_random   | Change default length (*12*).       |

> Each function description includes its **uc_** variables with examples.

### How to use

You either download the script to your computer, then source it from there:
```bash
source /path/to/utils.sh
```
Or source it using `curl` and the raw link from this GitHub repository:
```bash
source <(curl -Ls "https://raw.githubusercontent.com/Noam-Alum/utils.sh/main/utils.sh")
```
Note that by using curl each time the script runs you'd have to wait for a response with the functions.

* You can use a version that includes only the functions - `utils-min.sh`.

Click here to view examples:

[![Button Component](https://readme-components.vercel.app/api?component=button&text=examples)](examples)

## ![bash](https://raw.githubusercontent.com/rahul-jha98/README_icons/4d06112f039d3d302017842f696129642a58f6a5/language_and_tools/square/bash/bash-colored.svg) xecho - Extended echo

**xecho** is a utility designed to facilitate color usage in output,<br>
offering a variety of shortcodes for easy integration into your text.

### ShortCodes:
| ShortCode            | Result                          |
| -------------------- | ------------------------------- |
| **Blocks:**          |                                 |
| {{ ERROR }}          | [ERROR]  (text in red)          |
| {{ GOOD }}           | [GOOD] (text in green)          |
| {{ INFO }}           | [INFO] (text in grey)           |
| {{ WARNING }}        | [WARNING] (text in yellow)      |
| {{ ALERT }}          | [ALERT] (text in orange)        |
| {{ NOTE }}           | [NOTE] (text in blue)           |
| {{ IMPORTANT }}      | [IMPORTANT] (text in bold)      |
| {{ SUCCESS }}        | [SUCCESS] (text in light green) |
| **Faces:**           |                                 |
| {{ E-shocked }}      | ⊙▂⊙                             |
| {{ E-smile }}        | ʘ‿ʘ                             |
| {{ E-angry }}        | ಠ_ರೃ                             |
| {{ E-sad }}          | ◕︵◕                             |
| {{ E-nervous }}      | ⊙﹏⊙                             |
| **Other:**           |                                 |
| {{ E-gun }}          | ▄︻̷̿┻̿═━一                       |
| {{ E-heart }}        | ❤                               |
| {{ E-star }}         | ✮                               |
| {{ E-music }}        | ♫                               |
| {{ E-moon }}         | ☾                               |
| {{ E-cloud }}        | ☁︎                               |
| {{ E-arrowright }}   | ➜                               |
| {{ E-arrowleft }}    | ←                               |
| {{ E-redo }}         | ↺                               |
| {{ E-sleep }}        | ᶻz                              |
| {{ E-success }}      | ✔                               |
| {{ E-fail }}         | ✘                               |
| **Page breaks:**     |                                 |
| {{ BR-scissors }}    | -ˋˏ✄┈┈┈┈                         |
| {{ BR-star }}        | ────⋆⋅☆⋅⋆────                   |
| {{ BR-specialdots }} | ✦•┈๑⋅⋯ ⋯⋅๑┈•✦                   |
| {{ BR-heart }}       | ﮩ٨ـﮩﮩ٨ـ♡ﮩ٨ـﮩﮩ٨ـ                 |
| {{ BR-bear }}        | ━━━━━━ʕ•㉨•ʔ━━━━━━━              |
| {{ BR-music }}       | 01:43 ━━━━●───── 03:50          |
| **Text bullets:**    |                                 |
| {{ B-dot }}          | •                               |
| {{ B-arrow }}        | ➣                               |
| {{ B-dimond }}       | ◈                               |

### Tags:
| Color                                 | Tag        | Example                 |
|---------------------------------------|------------|-------------------------|
| Black                                 | `<b>`      | `<b>word</b>`           |
| Red                                   | `<r>`      | `<r>word</r>`           |
| Green                                 | `<g>`      | `<g>word</g>`           |
| Yellow                                | `<y>`      | `<y>word</y>`           |
| Blue                                  | `<bl>`     | `<bl>word</bl>`         |
| Purple                                | `<p>`      | `<p>word</p>`           |
| Cyan                                  | `<c>`      | `<c>word</c>`           |
| White                                 | `<w>`      | `<w>word</w>`           |
| **Bold Colors:**                      |            |                         |
| Bold Black                            | `<bb>`     | `<bb>word</bb>`         |
| Bold Red                              | `<br>`     | `<br>word</br>`         |
| Bold Green                            | `<bg>`     | `<bg>word</bg>`         |
| Bold Yellow                           | `<by>`     | `<by>word</by>`         |
| Bold Blue                             | `<bbl>`    | `<bbl>word</bbl>`       |
| Bold Purple                           | `<bp>`     | `<bp>word</bp>`         |
| Bold Cyan                             | `<bc>`     | `<bc>word</bc>`         |
| Bold White                            | `<bw>`     | `<bw>word</bw>`         |
| **Background Colors:**                |            |                         |
| Black background                      | `<on_b>`   | `<on_b>word</on_b>`     |
| Red background                        | `<on_r>`   | `<on_r>word</on_r>`     |
| Green background                      | `<on_g>`   | `<on_g>word</on_g>`     |
| Yellow background                     | `<on_y>`   | `<on_y>word</on_y>`     |
| Blue background                       | `<on_bl>`  | `<on_bl>word</on_bl>`   |
| Purple background                     | `<on_p>`   | `<on_p>word</on_p>`     |
| Cyan background                       | `<on_c>`   | `<on_c>word</on_c>`     |
| White background                      | `<on_w>`   | `<on_w>word</on_w>`     |
| **Bold High Intensity Colors:**       |            |                         |
| Bold High Intensity Black             | `<bib>`    | `<bib>word</bib>`       |
| Bold High Intensity Red               | `<bir>`    | `<bir>word</bir>`       |
| Bold High Intensity Green             | `<big>`    | `<big>word</big>`       |
| Bold High Intensity Yellow            | `<biy>`    | `<biy>word</biy>`       |
| Bold High Intensity Blue              | `<bibl>`   | `<bibl>word</bibl>`     |
| Bold High Intensity Purple            | `<bip>`    | `<bip>word</bip>`       |
| Bold High Intensity Cyan              | `<bic>`    | `<bic>word</bic>`       |
| Bold High Intensity White             | `<biw>`    | `<biw>word</biw>`       |
| **High Intensity Background Colors:** |            |                         |
| High Intensity Black background       | `<on_ib>`  | `<on_ib>word</on_ib>`   |
| High Intensity Red background         | `<on_ir>`  | `<on_ir>word</on_ir>`   |
| High Intensity Green background       | `<on_ig>`  | `<on_ig>word</on_ig>`   |
| High Intensity Yellow background      | `<on_iy>`  | `<on_iy>word</on_iy>`   |
| High Intensity Blue background        | `<on_ibl>` | `<on_ibl>word</on_ibl>` |
| High Intensity Purple background      | `<on_ip>`  | `<on_ip>word</on_ip>`   |
| High Intensity Cyan background        | `<on_ic>`  | `<on_ic>word</on_ic>`   |
| High Intensity White background       | `<on_iw>`  | `<on_iw>word</on_iw>`   |

**For example:**
```bash
xecho "<on_ic><bir>I love bash </bir></on_ic><on_ir><bic> {{ E-heart }} </bic></on_ir>"
```
**Results:**<br>
<span style="color: red; background-color: cyan;">I love bash </span><span style="color: cyan; background-color: red;"> ❤ </span>

## ![bash](https://raw.githubusercontent.com/rahul-jha98/README_icons/4d06112f039d3d302017842f696129642a58f6a5/language_and_tools/square/bash/bash-colored.svg) ifcontinue

**ifcontinue** is a function meant to return binary response to a yes-or-no question.

**For example:**
```bash
if [ $(ifcontinue "{{ B-dot }} Do <on_bl>you</on_bl> want to go <bb>do something</bb>?") -eq 0 ]; then
  xecho "Good - <g>{{ E-smile }}</g>"
else
  xecho "Bad - <g>{{ E-sad }}</g>"
fi
```

**Results**<br>
• Do <span style="color: white; background-color: blue;">you</span> want to go <strong>do something</strong>? [<span style="color: green;">yes</span>/<span style="color: red;">no</span>] : yes<br>
Good - <span style="color: green;">ʘ‿ʘ</span>

### uc variables:

`uc_ifc_posfix` - Change default posfix (*[yes/no]*).
For example:
```bash
uc_ifc_posfix="<bl>yes</bl>|<bir>no</bir> - "
```
Would change "[<span style="color: green;">yes</span>/<span style="color: red;">no</span>]" to "<span style="color: blue;">yes</span>|<span style="color: red;">no</span> -".

## ![bash](https://raw.githubusercontent.com/rahul-jha98/README_icons/4d06112f039d3d302017842f696129642a58f6a5/language_and_tools/square/bash/bash-colored.svg) user_input

**user_input** is a function meant to take user input in and save it as a variable<br>
in the best way posable.

### Types

- **mail:** validates a mail address.
     ```bash
     user_input mail "mail" "What is your mail address?"
     ```
- **int:** only accepts integers, you can choose a range, if you dont want just use plane `int`.
     ```bash
     user_input age "int 1 100" "What is your age?"
     # OR
     user_input age "int" "What is your age?"
     ```
- **str:** accepts only charecters.
     ```bash
     user_input string "str" "What is your name?"
     ```
- **opt:** accepts only selection of inputs given after opt.
     ``` bash
     user_input num "opt one two three four" "What number?"
     ```
- **txt:** accepts both integers and charecters.
     ``` bash
     user_input username "txt" "What is your username?"
     ```

**For example:**
```bash
user_input protocol "opt tcp udp" "<g>{{ B-arrow }}</g> What protocol do you want to use? [<bl>tcp</bl>/<r>udp</r>] : "
```
**Result:**<br>
<span style="color: green">➣</span> What protocol do you want to use? [<span style="color: blue">tcp</span>/<span style="color: red">udp</span>] : udp<br>
(Now a variable named "protocol" was created with the value of "udp")

## ![bash](https://raw.githubusercontent.com/rahul-jha98/README_icons/4d06112f039d3d302017842f696129642a58f6a5/language_and_tools/square/bash/bash-colored.svg) gen_random

Generate random data.

Options:
- int | Only use numbers.
- str | Only use alphabetic characters.
- all | Use anything.

**For example:**
```bash
gen_random int 14
```
**Would return:**<br>
36261766974132
 
### uc variables:
 
`uc_gr_len` - Change default length (*12*).<br>
For example:
```bash
uc_gr_len=8
```
