# ZI
if [[ ! -f $HOME/.zi/bin/zi.zsh ]] {
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
}
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

# starship
eval "$(starship init zsh)"

# iterm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# ZSH Option

ZI[OPTIMIZE_OUT_DISK_ACCESSES]=1 # slightly faster

## history
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS INC_APPEND_HISTORY

HISTFILE=~/.zsh_history
HISTSIZE=3000
SAVEHIST=10000

## pushd and other
setopt AUTO_PUSHD AUTO_CD AUTO_LIST AUTO_LIST PUSHD_IGNORE_DUPS INTERACTIVE_COMMENTS

## LS color, defined esp. for cd color, 'cause exa has its own setting
export CLICOLOR=1
export LSCOLORS=ExGxFxdaCxDaDahbadeche

## completion settings - pretty print - ignore case
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format '[%d]'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' rehash true
zstyle ":history-search-multi-word" page-size "11"
zstyle ':completion:*' menu select

[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor

# env
## editor
export EDITOR=code

## lang
export LANG=en_US.UTF-8

## Brew
export HOMEBREW_NO_ANALYTICS="true"
export HOMEBREW_NO_ENV_HINTS="true"

## ruby
export PATH="$BREW_PREFIX/opt/ruby/bin:$PATH"

export CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER=x86_64-linux-gnu-gcc
export CC_x86_64_unknown_linux_gnu=x86_64-linux-gnu-gcc
export CXX_x86_64_unknown_linux_gnu=x86_64-linux-gnu-g++
export AR_x86_64_unknown_linux_gnu=x86_64-linux-gnu-ar

## CPM, see: https://github.com/cpm-cmake
export CPM_SOURCE_CACHE="$HOME/.cache/CPM"

## pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

## brew install llvm
if [[ -d "$LLVM_HOME" ]] {
  export PATH="$LLVM_HOME/bin:$PATH"
  export CC="$LLVM_HOME/bin/clang"
  export CXX="$LLVM_HOME/bin/clang++"
}

# zsh modules
zi light-mode for \
  z-shell/z-a-meta-plugins \
  Aloxaf/fzf-tab \
  @annexes+\
  @zunit \

# does not work for now
# zi ice atload"zpcdreplay" atclone"./zplug.zsh" atpull"%atclone"
# zi light g-plane/pnpm-shell-completion

zi wait lucid light-mode depth"1" for \
  blockf has'lsd' \
    "https://gist.githubusercontent.com/Colerar/18fdd01a4231760545542c31835a09a6/raw/zsh-lsd-aliases.sh" \
  atinit"ZI[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    z-shell/F-Sy-H \
  atload"_zsh_autosuggest_start;" \
    zsh-users/zsh-autosuggestions \
  multisrc="*.zsh" pick"/dev/null" \
    Colerar/omz-extracted \
  blockf has'zoxide' \
    https://gist.githubusercontent.com/Colerar/ff82d2c9c6211da846b20df146cfa272/raw/zoxide.zsh \
  blockf has'git' atload'export GPG_TTY=$(tty)' pick="lib/git.zsh" \
    ohmyzsh/ohmyzsh \
  blockf has'git' pick="plugins/git/git.plugin.zsh" \
    ohmyzsh/ohmyzsh \
  blockf has'pbcopy' pick="plugins/macos/macos.plugin.zsh" \
    ohmyzsh/ohmyzsh \
  blockf has'code' pick="plugins/vscode/vscode.plugin.zsh" \
    ohmyzsh/ohmyzsh \
  blockf has'asdf' \
    https://gist.githubusercontent.com/Colerar/0280581a4c7e0fd949d475f48ad779cf/raw/asdf.zsh \
  z-shell/zzcomplete \
  blockf has'sudo' pick="plugins/sudo/sudo.plugin.zsh" \
    ohmyzsh/ohmyzsh \

zi wait'1' lucid light-mode depth"1" for \
  as'completion' \
    /Users/col/Developer/completions/completions/heif-enc/zsh/_heif-enc \
  as'completion' \
    zsh-users/zsh-completions \
  as'completion' blockf has'cargo' \
    https://raw.githubusercontent.com/rust-lang/cargo/master/src/etc/_cargo \
  blockf has'yarn' pick="plugins/yarn/yarn.plugin.zsh" \
    ohmyzsh/ohmyzsh \
  atload'
        export znt_history_active_text="reverse"
        export znt_list_colorpair="white/24"
        export znt_list_bold="1"' \
    z-shell/zsh-navigation-tools \
  z-shell/ZUI \
  as'completion' blockf has'exa' \
    https://raw.githubusercontent.com/ogham/exa/master/completions/zsh/_exa \
  as'completion' blockf has'rustc' \
    https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/rust/_rustc \
  as'completion' blockf has'tmux' pick'completion/zsh' \
    greymd/tmux-xpanes \
  as'completion' blockf has'yadm' \
    https://raw.githubusercontent.com/TheLocehiliosan/yadm/master/completion/zsh/_yadm \
  as'completion' blockf has'tracks' atload"source $HOME/.zi/completions/_tracks" \
    https://raw.githubusercontent.com/Colerar/Tracks/cli/completions/_tracks \
  as'completion' blockf has'pandoc' \
    srijanshetty/zsh-pandoc-completion \
  as'completion' \
    /Users/col/.sdkman/contrib/completion/bash/sdk \
  blockf has'brew' pick="plugins/brew/brew.plugin.zsh" \
    ohmyzsh/ohmyzsh \
  blockf has'gradle' pick="plugins/gradle/gradle.plugin.zsh" \
    ohmyzsh/ohmyzsh \
  "https://gist.githubusercontent.com/Colerar/2f23c76583ac7866a50cda5bb04ff3a4/raw/sha-alias.plugin.zsh" \
  blockf pick="plugins/extract/extract.plugin.zsh" \
    ohmyzsh/ohmyzsh \

# Key Bindings

# \e, \E = Escape
# ^[     = Alt / Option
# ^X, ^  = Control
# ^?     = Delete

# Option + Left
bindkey "^[[1;9D" backward-word
bindkey "^[b"     backward-word
# Option + Right
bindkey "^[[1;9C" forward-word
bindkey "^[f"     forward-word

if [[ "$VSCODE_INJECTION" -ne 1 ]] {
bindkey -s "^B" "zo^m"
bindkey -s "^W" "btm --expanded^M"
}

# alias

## vim
alias nvim=lvim
alias vi=lvim
alias vim=lvim
alias neovim=/opt/homebrew/bin/nvim

## rm
rm! () {
  /bin/rm "$@"
}

##gdb
alias gdb=aarch64-elf-gdb

rm () {
  echo "Moving to ~/.Trash: ["
  for i in "$@"; do
    echo "  $i"
  done
  echo "]"
  /bin/mv -f $@ ~/.trash/
}

emptytrash () {
  sudo /bin/rm -rf ~/.trash/*
}

## grep
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'

## jenv
export PATH="$HOME/.jenv/shims:${PATH}"
export JENV_SHELL=zsh
export JENV_LOADED=1
unset JAVA_HOME
unset JDK_HOME
jenv() {
  type typeset &> /dev/null && typeset command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi
  case "$command" in
  enable-plugin|rehash|shell|shell-options)
    eval `jenv "sh-$command" "$@"`;;
  *)
    command jenv "$command" "$@";;
  esac
}

update-jenvs () {
  eval "$(jenv init -)"
  /bin/rm -rf "~/.jenv"
  local readonly jenv_global=$(jenv global)
  fd --type directory --regex '.*\.jdk' /Library/Java/JavaVirtualMachines -x jenv add '{}/Contents/Home'
  fd --type directory --regex 'openjdk\.jdk' --exact-depth=4 "$(brew --prefix)/Cellar/" -x jenv add '{}/Contents/Home'
  fd -t=file --glob '*zulu*.pkg' "$(brew --prefix)/Caskroom/" -X rm -rf '{}'
  jenv rehash
  jenv global "$jenv_global"
}

## eza
alias exa=eza
alias lx="eza -a --icons -G -l"
alias la="eza -a -G"
