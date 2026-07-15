'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob
  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'
  [[ $ZSH_VERSION == (5.<1->*|<6->.*) ]] || return

  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    dir vcs newline prompt_char
  )
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

  typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=v3
  typeset -g POWERLEVEL9K_DIR_VISUAL_IDENTIFIER_EXPANSION=

  typeset -g POWERLEVEL9K_MODE=nerdfont-v3
  typeset -g POWERLEVEL9K_ICON_PADDING=none
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false

  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=""
  typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=""
  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=" "
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=""
  typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=""
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL=""
  typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=""
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=""

  typeset -g POWERLEVEL9K_DIR_BACKGROUND=none
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=6
  typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=6
  typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=6
  typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=""

  typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND=none
  typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=none
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=none
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=5
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=3
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=5
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=""
  typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)

  typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=none
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VIINS_FOREGROUND=6
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VIINS_FOREGROUND=1
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VIINS_CONTENT_EXPANSION='→'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VIINS_CONTENT_EXPANSION='→'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=""
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_LEFT_WHITESPACE=""
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_RIGHT_WHITESPACE=" "

  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=always
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

  (( ! $+functions[p10k] )) || p10k reload
}

typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}
(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
