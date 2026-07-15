eval $(dircolors -b)

# Instant prompt (must be at the very top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ── Plugins ──────────────────────────────────────────────────────────────────
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
# Adjust the paths above if yours differ (check with: pacman -Ql zsh-theme-powerlevel10k)

# Syntax highlighting & autosuggestions (install via pacman if missing)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# ── Completion ────────────────────────────────────────────────────────────────
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} m:{A-Z}={a-z}'

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# separate matches into groups
zstyle ':completion:*:*:*:*:*' menu select

# ── History ───────────────────────────────────────────────────────────────────
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# ── Env ───────────────────────────────────────────────────────────────────────
export EDITOR=nvim
export VISUAL=nvim
export VULKAN_SDK=/usr
export CMAKE_BUILD_PARALLEL_LEVEL=3
export PATH="$HOME/.local/bin:$PATH"
export LFS="/mnt/lfs"

# ── Aliases ───────────────────────────────────────────────────────────────────
# navigation
alias ..="cd .."
alias ...="cd ../.."
alias l="ls -lah"
alias ls='ls --color=auto'
alias ts="~/dots/scripts/tmux-sessionizer.sh"

# tools
alias vim="nvim"
alias nano="nvim"
alias e="exit"
alias ff="fastfetch"
alias cat="bat"

# git
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"
alias gl="git log --oneline --graph"

# ── p10k ──────────────────────────────────────────────────────────────────────
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH=$PATH:~/.spicetify
