# -----------------------------------------------------------------------------
# Powerlevel10k 即时提示 (Instant Prompt) 功能
# -----------------------------------------------------------------------------
# 这是 Powerlevel10k 主题的一个核心优化功能。
# 它会缓存第一次启动终端时的初始化信息。
# 当你再次打开终端时，它会先加载这个缓存文件，让你几乎可以"瞬间"看到命令提示符，
# 然后再在后台加载其他的配置（如插件等），极大地提升了 Zsh 的启动速度。
#
# - `[[ -r "..." ]]`: 检查指定的缓存文件是否存在且可读。
# - `${XDG_CACHE_HOME:-$HOME/.cache}`: 使用 XDG 基本目录规范。如果设置了 $XDG_CACHE_HOME 环境变量，
#   则使用该路径，否则默认使用 ~/.cache。这是一种让家目录保持整洁的现代实践。
# - `${(%):-%n}`: 这是 Zsh 的参数展开，会获取当前用户的用户名。
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -----------------------------------------------------------------------------
# 历史记录 (History) 设置
# -----------------------------------------------------------------------------
# 设置历史记录文件的存放位置。这里同样使用了 XDG 规范，
# $XDG_STATE_HOME 默认指向 ~/.state，用于存放用户的状态文件。
HISTFILE="$XDG_STATE_HOME"/zsh/history

# 设置在当前会话（内存）中保留的历史命令数量。
HISTSIZE=2000
# 设置在历史文件（HISTFILE）中保存的命令数量。
SAVEHIST=2000

# 将新的历史记录追加到历史文件中，而不是每次都覆盖整个文件。
setopt APPEND_HISTORY
# 让所有打开的终端窗口共享同一份历史记录。在一个窗口输入的命令，会立刻出现在另一个窗口的历史中。
setopt SHARE_HISTORY
# 从历史记录中删除所有重复的命令，只保留最新的那一条。
setopt HIST_IGNORE_ALL_DUPS
# 在搜索历史时（例如按上箭头或 Ctrl+R），不显示重复的命令。
setopt HIST_FIND_NO_DUPS
# 不保存任何以空格开头的命令。这对于输入包含密码等敏感信息的命令非常有用。
setopt HIST_IGNORE_SPACE
# 记录每条命令执行的时间戳和所花费的时间。
setopt EXTENDED_HISTORY

# -----------------------------------------------------------------------------
# Zsh 自动补全样式与路径配置
# -----------------------------------------------------------------------------
# 1. 首先，设置 fpath，让 Zsh 知道去哪里找 zsh-completions 的补全脚本
# fpath=(~/.config/zsh/zsh-completions/src $fpath)

# 2. 接着，设置所有 zstyle 样式，定义补全菜单的外观和行为
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:*:*:*:*' menu-select 'fg=white,bg=blue'
zstyle ':completion:*' group-name ''

# -----------------------------------------------------------------------------
# 手动加载插件 (Manual Plugin Sourcing)
# -----------------------------------------------------------------------------

# 将 zsh-completions 插件的目录添加到 Zsh 函数搜索路径 ($fpath) 的最前面
# 这样 Zsh 就能找到该插件提供的所有补全脚本
fpath=(~/.config/zsh/zsh-completions/src $fpath)

# 加载 `zsh-syntax-highlighting` 插件，它会为你的命令行输入提供语法高亮。
# 正确的命令会显示为绿色，错误的命令会显示为红色，路径和参数也会有不同颜色。
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# 加载 `zsh-autosuggestions` 插件，它会根据你的历史记录，
# 以灰色文字提示你可能想要输入的命令。按右方向键 `→` 或 `End` 键即可补全。
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# 加载 `zsh-history-substring-search` 插件
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

# 加载 `powerlevel10k` 的主题文件，这个文件定义了命令提示符（Prompt）的外观和行为。
source ~/.config/zsh/zsh-powerlevel10k/powerlevel10k.zsh-theme

# -----------------------------------------------------------------------------
# 别名 (Aliases)
# -----------------------------------------------------------------------------
# `cls` 是 Windows CMD 中清屏命令的别名，这里让它在 Zsh 中也能用。
alias cls='clear'
# `ll` 是一个非常常用的别名，用于以详细、人性化（文件大小）的格式列出所有文件（包括隐藏文件）。
alias ll='ls -alh'
# 为 `nano` 编辑器创建一个更短的别名。
alias nn='nano'
# 为 systemd 服务创建快捷操作别名：重启服务。
alias sr='systemctl restart'
# 为 systemd 服务创建快捷操作别名：查看服务状态。
alias st='systemctl status'

# 以下是后缀别名（Suffix Alias），是 Zsh 的一个强大功能。
# `-s` 表示这是一个后缀别名。当你直接在命令行输入以该后缀结尾的文件名时，
# Zsh 会自动在前面加上指定的命令。

# 例如，输入 `my_archive.tar.gz` 然后回车，会自动执行 `tar -xzvf my_archive.tar.gz`。
alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
# 例如，输入 `my_archive.zip` 然后回车，会自动执行 `unzip my_archive.zip`。
alias -s zip='unzip'

# ------------------------------------------------------------------
# COMPLETIONS (自动补全)
# ------------------------------------------------------------------
# 补全系统初始化 (必须在所有插件和 zstyle 配置后)
autoload -U compinit
compinit

# -----------------------------------------------------------------------------
# 按键绑定 (Keybindings)
# -----------------------------------------------------------------------------
# 将 history-substring-search 插件的功能绑定到上下方向键
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down
# 如果你的终端或键盘设置不同，上面的可能无效，可以试试下面的（通常用于 PuTTY 等）
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# -----------------------------------------------------------------------------
# 加载 Powerlevel10k 用户配置文件
# -----------------------------------------------------------------------------
# 这行代码的作用是加载由 `p10k configure` 命令生成的个人配置文件。
# 这个文件（`.p10k.zsh`）保存了你对提示符样式的所有定制化选项（如颜色、图标、显示内容等）。
#
# - `[[ ! -f ... ]]`: 检查文件是否“不”存在 (`! -f`)。
# - `||`: 逻辑 "或"。
# - 整个语句的逻辑是：“如果 `.p10k.zsh` 文件不存在，则什么也不做；
#   否则 (OR)，就 `source` 这个文件”。这是一种简洁的“如果文件存在则加载”的写法。
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh