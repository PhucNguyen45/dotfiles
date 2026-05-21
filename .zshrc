# ===================================================
#  .zshrc - Zsh configuration for WSL Ubuntu 26.04
#  Tự cấu hình thủ công + Zinit (Turbo) quản lý plugin + Powerlevel10k Instant Prompt
# ===================================================

# ----- 0. Instant Prompt (Powerlevel10k) – phải đặt đầu file -----
# Cho phép hiển thị prompt ngay lập tức, plugin tải trong nền
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ----- 1. Thiết lập cơ bản (History, Options, Env) -----
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000

setopt EXTENDED_HISTORY          # Lưu timestamp cho mỗi lệnh
setopt APPEND_HISTORY            # Luôn thêm vào file lịch sử (không ghi đè)
setopt INC_APPEND_HISTORY        # Ghi lịch sử ngay lập tức sau mỗi lệnh
setopt SHARE_HISTORY             # Chia sẻ lịch sử giữa các phiên
setopt HIST_IGNORE_DUPS          # Không lưu lệnh trùng liên tiếp
setopt HIST_IGNORE_SPACE         # Bỏ qua lệnh bắt đầu bằng dấu cách
setopt HIST_IGNORE_ALL_DUPS      # Xóa lệnh cũ trùng nếu có lệnh mới

export NO_AT_BRIDGE=1
export XDG_SESSION_TYPE=wayland

# ----- 2. Khởi tạo Zinit (Plugin Manager) -----
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load các annex quan trọng (bắt buộc cho một số tính năng mở rộng)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# ----- 3. Plugin via Zinit (Turbo mode) -----
# Autosuggestions (gợi ý lệnh)
zinit light zsh-users/zsh-autosuggestions

# Syntax highlighting (tô màu cú pháp)
zinit ice wait lucid atload'ZINIT[COMPINIT_OPTS]=-C; zpcompinit'
zinit light zsh-users/zsh-syntax-highlighting

# Autopair (tự động đóng ngoặc, nháy)
zinit ice wait lucid
zinit light hlissner/zsh-autopair

# zsh-completions (completion mở rộng)
zinit ice wait lucid atload'zicompinit; zicdreplay'
zinit load zchee/zsh-completions

# mise (quản lý phiên bản đa ngôn ngữ)
zinit ice as"command" from"gh-r" extract'!' mv"mise* -> mise" pick"mise" atload'eval "$(mise activate zsh)"'
zinit light jdx/mise
export MISE_TRUSTED_CONFIG_PATHS="$HOME/workspace"

# ----- 4. Cấu hình riêng cho plugin -----
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey '^ ' autosuggest-accept

# ----- 5. Giao diện Prompt (Powerlevel10k) -----
source ~/.zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ----- 6. Tự động hoàn thành (Completion) -----
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit
compinit -d ~/.zsh/compdump

# ----- 7. Aliases di chuyển nhanh -----
# Alias lùi thư mục tự động clear và liệt kê
alias ..='cd .. && clear && la'
alias ...='cd ../.. && clear && la'
alias ....='cd ../../.. && clear && la'
alias ~='cd ~ && clear && la'
alias //='cd / && clear && la'

# ----- 8. Modern CLI Tools -----
alias ls='eza --icons=always --group-directories-first'
alias ll='eza -l --icons=always --group-directories-first --git'
alias la='eza -a --icons=always --group-directories-first'
alias tree='eza --tree --icons=always'
alias cat='batcat --paging=never'
alias grep='rg --smart-case'
alias find='fdfind'
alias y='yazi'

eval "$(zoxide init zsh)"
export TEALDEER_CACHE_DIR="$HOME/.cache/tealdeer"
# Override z (zoxide) để thêm clear + list sau khi nhảy thư mục thành công
# Giữ nguyên khả năng tương tác fzf khi gõ `z` không tham số
if typeset -f __zoxide_z >/dev/null 2>&1; then
    z() {
        if [ $# -eq 0 ]; then
            __zoxide_z
        else
            __zoxide_z "$@"
            local ret=$?
            if [ $ret -eq 0 ]; then
                clear
                la
            fi
            return $ret
        fi
    }
fi

# (Giữ lại function c nếu bạn muốn cd đường dẫn tuyệt đối + clear + list)
c() {
    if [ $# -eq 0 ]; then
        cd ~ && clear && la
    else
        cd "$@" && clear && la
    fi
}

# ----- 9. fzf -----
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview "
  if [ -d {} ]; then
    eza --tree --icons=always --color=always {}
  else
    batcat --style=numbers --color=always {}
  fi"'
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# ----- 10. Fastfetch (bỏ comment để bật) -----
# fastfetch

# ----- 11. SSH Agent -----
export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
if ! ssh-add -l > /dev/null 2>&1; then
    rm -f "$SSH_AUTH_SOCK"
    ssh-agent -a "$SSH_AUTH_SOCK" > /dev/null
    ssh-add -q ~/.ssh/id_ed25519 2>/dev/null
fi

# ----- 12. Broot -----
source /home/razer_admin/.config/broot/launcher/bash/br

. "$HOME/.local/bin/env"

# Hermes Agent — ensure ~/.local/bin is on PATH
export PATH="$HOME/.local/bin:$PATH"
