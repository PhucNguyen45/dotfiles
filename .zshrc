# ===== Thiết lập cơ bản =====
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY          # Chia sẻ lịch sử giữa các phiên
setopt INC_APPEND_HISTORY     # Ghi lịch sử ngay lập tức

# Tự động hoàn thành (completion)
autoload -Uz compinit
compinit

# ===== Plugin =====
# Gợi ý lệnh (suggestions)
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# ===== Giao diện Prompt =====
source ~/.zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Để cấu hình giao diện prompt, chạy lệnh sau khi khởi động lại shell:
# p10k configure

# SSH Agent
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"
ssh-add -q ~/.ssh/id_ed25519 2>/dev/null

# ===== Modern CLI Tools (Aliases & Integrations) =====
# Thay thế các lệnh cổ điển bằng phiên bản Rust siêu tốc

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
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# Fastfetch – thông tin hệ thống khi mở terminal
# (nếu muốn tắt để tăng tốc startup, thêm dấu # trước dòng dưới)
fastfetch

# ===== Tô màu cú pháp (phải nằm cuối cùng) =====
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
