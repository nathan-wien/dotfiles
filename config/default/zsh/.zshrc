function source_if_exists () {
  FILE=$1 && test -e $FILE && source $FILE
}

# -----------------------------------------------------------------------------
#                               Local Configs
# -----------------------------------------------------------------------------
source_if_exists "$HOME/.config/zsh/local.zsh"
source_if_exists "$HOME/.config/zsh/proxy.zsh"
source_if_exists "$HOME/.config/zsh/private.zsh"

# -----------------------------------------------------------------------------
#                              Shell settings
# -----------------------------------------------------------------------------
# tab-complete hidden items
_comp_options+=(globdots)
# editor
if [ -x "nvim" ] ; then
   export EDITOR=nvim
else
   export EDITOR=vim
fi

# -----------------------------------------------------------------------------
#                                App settings
# -----------------------------------------------------------------------------
# vi-mode (disable in nvim terminal)
# env | grep -q "NVIM_LISTEN_ADDRESS" || bindkey -v

# fzf
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
source_if_exists "$HOME/.config/fzf/completion.zsh"
source_if_exists "$HOME/.config/fzf/key-bindings.zsh"

# vivid
if [ -x "vivid" ] ; then
  export LS_COLORS="$(vivid -m 8-bit generate one-light)"
fi

# zsh
source_if_exists "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source_if_exists "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
bindkey '^Y' autosuggest-accept
bindkey -v

# -----------------------------------------------------------------------------
#                                  Aliases
# -----------------------------------------------------------------------------
# [ -x "$(command -v nvim)" ] && alias vim="nvim"
[ -x "$(command -v exa)" ] && alias ls="exa"
[ -x "$(command -v bat)" ] && alias cat="bat"
[ -x "$(command -v direnv)" ] && eval "$(direnv hook zsh)"

# -----------------------------------------------------------------------------
#                                   Theme
# -----------------------------------------------------------------------------
if [ -x "$(command -v starship)" ] ; then
  # Starship: https://github.com/starship/starship
  eval "$(starship init zsh)"
fi
