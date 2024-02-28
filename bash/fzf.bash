# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/prj/dotfiles/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/prj/dotfiles/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/prj/dotfiles/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$HOME/prj/dotfiles/fzf/shell/key-bindings.bash"
