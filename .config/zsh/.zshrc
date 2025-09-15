if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE="$XDG_STATE_HOME"/zsh/history
# 设置保存在内存和文件中的历史命令数量
HISTSIZE=2000
SAVEHIST=2000
# 将新历史追加到历史文件中，而不是覆盖
setopt APPEND_HISTORY
# 在所有打开的 shell 之间共享历史
setopt SHARE_HISTORY
# 不保存重复的命令
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
# 不保存以空格开头的命令
setopt HIST_IGNORE_SPACE
# 保存命令的时间戳和执行时长
setopt EXTENDED_HISTORY

source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-powerlevel10k/powerlevel10k.zsh-theme

alias cls='clear'
alias ll='ls -alh'
alias nn='nano'
alias sr='systemctl restart'
alias st='systemctl status'
alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'

[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
