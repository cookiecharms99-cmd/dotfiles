
# -- Navigation ----
alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -lah --color=auto'

# -- Git ------
#
#
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline -10'

# --- Editor --
export EDITOR=zed
export VISUAL=zed


# Functions!
mkcd() {
	mkdir -p -- "$1" && cd -- "$1"
}

alias activate_pyvenv='source .venv/bin/activate'

alias python='python3'




echo -e "\e[1;35m🌸 Welcome back, jonjon! :D 🌸\e[0m"

get_rainbow_prompt() {
	local exit_code=$?




    # Red, Yellow, Green, Cyan, Blue, Pink
	local rainbow_colors=(31 33 32 36 34 35)
    
    # Check if index exists (Notice the spaces inside [ and ])
    	if [ -z "$rainbow_idx" ]; then
        rainbow_idx=0
    	fi
    
    # Set the current color (No spaces around the = sign)
    	local color=${rainbow_colors[$rainbow_idx]}
    
    # Your beautiful pool of faces
    	local FACES=("(*^ω^*)"
		     "(≧◡≦)"
		     "(◕‿◕✿)"
 	             "(*ﾉ▽ﾉ)"
 	             "(◌^-^◌)"
	             "(◠‿◠✿)") 
    	local FACE=${FACES[$((RANDOM % ${#FACES[@]}))]}
    


	#-----------------
	# Git info :3
	#------------------
	local git_info=""
	if git rev-parse --is-inside-work-tree &>/dev/null; then
		local branch
		branch=$(git branch --show-current 2>/dev/null)
		
		if [ -n "$branch" ]; then 
			git_info=" \[\e[1;35m\]git:${branch}\[\e[0m\]"
		fi
	fi
	#---------------------
	# Virtual Environments
	#---------------------
	local venv_info=""
		if [ -n "$VIRTUAL_ENV" ]; then
			local venv_name
			venv_name=$(basename "$VIRTUAL_ENV")
			venv_info=" \[\e[1;36m\]py:${venv_name}\[\e[0m\]"
		fi

	

	#------------------------
	# ~~~ Prompt Assembly!! ~~~
	#-------------------------

	PS1="\[\e[1;${color}m\]♡♡ ${FACE} jonjon ☾.°˖✧\[\e[0m\]  "
        PS1+="\[\e[1;37m\]\w\[\e[0m\]"
        PS1+="${git_info}${venv_info}"
        PS1+="\n\[\e[1;${color}m\]$\[\e[0m\] "


    
    # Move to the next rainbow color for the next line!
    	rainbow_idx=$(( (rainbow_idx + 1) % 6 ))
}
# Tell Mint to run your function
PROMPT_COMMAND=get_rainbow_prompt




up() {
    local levels=${1:-1}
    local cd_cmd=""
    
    # Check if the input is a valid positive number
    if [[ "$levels" =~ ^[0-9]+$ ]]; then
        for ((i=0; i<levels; i++)); do
            cd_cmd="../$cd_cmd"
        done
        cd "$cd_cmd"
    else
        echo "Usage: up [number_of_levels]"
    fi
}
