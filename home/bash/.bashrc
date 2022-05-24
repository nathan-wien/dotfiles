# Local config
FILE="$HOME/.bash/local.bash" && test -f $FILE && source $FILE

# Aliases
[ -x "$(command -v nvim)" ] && alias vim="nvim";
[ -x "$(command -v exa)"  ] && alias ls="exa";

# Theme
[ -x "$(command -v starship)" ] && eval "$(starship init bash)"