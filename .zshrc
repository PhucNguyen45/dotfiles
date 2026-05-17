# ===== Thiết lập cơ bản =====
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000
HIST_STAMPS="yyyy-mm-dd"

setopt EXTENDED_HISTORY
setopt SHARE_HISTORY          # Chia sẻ lịch sử giữa các phiên
setopt INC_APPEND_HISTORY     # Ghi lịch sử ngay lập tức
setopt HIST_IGNORE_DUPS       # Không lưu lệnh trùng liên tiếp
setopt HIST_IGNORE_SPACE      # Không lưu lệnh bắt đầu bằng dấu cách
setopt HIST_IGNORE_ALL_DUPS   # Xóa lệnh cũ trùng khi có lệnh mới

# Ngăn thông báo lỗi dbus trên WSL
export NO_AT_BRIDGE=1
export XDG_SESSION_TYPE=wayland

# Tự động hoàn thành (completion)
# Cho phép cache để load nhanh hơn nhiều lần sau
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
# Giao diện menu completion
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# Tìm kiếm "mờ": gõ chữ thường khớp cả chữ hoa
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
# zsh-completions
fpath=(~/.zsh/plugins/zsh-completions/src $fpath)
# Khởi tạo completion engine
autoload -Uz compinit
compinit -d ~/.zsh/compdump

# ===== Plugin =====
# Gợi ý lệnh (suggestions)
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# Gợi ý dựa trên cả history và completion
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# Phím Ctrl+Space để chấp nhận gợi ý ngay lập tức
bindkey '^ ' autosuggest-accept

# ===== Giao diện Prompt =====
source ~/.zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Để cấu hình giao diện prompt, chạy lệnh sau khi khởi động lại shell:
# p10k configure

# SSH Agent với socket cố định, tránh trùng lặp
export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
if ! ssh-add -l > /dev/null 2>&1; then
    # Khởi động agent nếu chưa có
    rm -f "$SSH_AUTH_SOCK"
    ssh-agent -a "$SSH_AUTH_SOCK" > /dev/null
    ssh-add -q ~/.ssh/id_ed25519 2>/dev/null
fi

# ===== Modern CLI Tools (Aliases & Integrations) =====
# Thay thế các lệnh cổ điển bằng phiên bản Rust siêu tốc

# aliases di chuyển nhanh hơn
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

# ls → eza (hiển thị đẹp, icon, git status)
alias ls='eza --icons=always --group-directories-first'
alias ll='eza -l --icons=always --group-directories-first --git'
alias la='eza -a --icons=always --group-directories-first'
alias tree='eza --tree --icons=always'

# cat → bat (tô màu cú pháp, tích hợp git)
alias cat='batcat --paging=never'

# grep → ripgrep (tìm kiếm nhanh, tôn trọng .gitignore)
alias grep='rg --smart-case'

# find → fd-find (cú pháp dễ dùng hơn)
alias find='fdfind'

# cd thông minh với zoxide (tự động ghi nhớ thư mục hay dùng)
eval "$(zoxide init zsh)"

# tldr (tealdeer) – hiển thị ví dụ ngắn gọn cho các lệnh
export TEALDEER_CACHE_DIR="$HOME/.cache/tealdeer"

# fzf – tìm kiếm mờ (Ctrl+R lịch sử, Ctrl+T file, Alt+C thư mục)
# Giao diện fzf đẹp và có preview
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview "
  if [ -d {} ]; then
    eza --tree --icons=always --color=always {}
  else
    batcat --style=numbers --color=always {}
  fi"'
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# Fastfetch – thông tin hệ thống khi mở terminal
# (nếu muốn tắt để tăng tốc startup, thêm dấu # trước dòng dưới)
# fastfetch

# ===== Tô màu cú pháp (phải nằm cuối cùng) =====
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Broot
source /home/razer_admin/.config/broot/launcher/bash/br
