# KISS.zsh-theme


# This theme is based on fino theme
# 
# Original documents:
# Use with a dark background and 256-color terminal!
# Meant for people with rbenv and git. Tested only on OS X 10.7.

# You can set your computer name in the ~/.box-name file if you want.

# Borrowing shamelessly from these oh-my-zsh themes:
#   bira
#   robbyrussell
#
# Also borrowing from http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/

# New documents:
#

function prompt_char {
  git branch >/dev/null 2>/dev/null && echo "±$" && return
  echo '○$'
}

function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || echo ${SHORT_HOST:-$HOST}
}

local ruby_env='using%{$FG[243]%} $(ruby_prompt_info)'

function virtualenv_info { 
if [ -z $VIRTUAL_ENV ]
then
    py_str=''
else
    py_str='('`basename $VIRTUAL_ENV`')'
fi
echo $py_str
}


# local py_env=`basename $VIRTUAL_ENV` 

local git_info='$(git_prompt_info)'
local prompt_char='$(prompt_char)'


PROMPT="╭─%{$FG[040]%}%n%{$reset_color%}%{$FG[239]%}@%{$FG[033]%}$(box_name)%{$terminfo[bold]$FG[226]%}[%5~]%{$reset_color%}${git_info}%{$FG[147]%}$(virtualenv_info)
%{$FG[118]%}╰─o[%T]$%{$reset_color%} "


ZSH_THEME_GIT_PROMPT_PREFIX="{"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[202]%}✘✘✘"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[040]%}✔"
ZSH_THEME_RUBY_PROMPT_PREFIX="‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="›%{$reset_color%}"


