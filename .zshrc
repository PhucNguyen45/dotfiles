# Created by newuser for 5.9

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

# Tô màu cú pháp (phải nằm cuối cùng)
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ===== Giao diện Prompt =====
source ~/.zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Để cấu hình giao diện prompt, chạy lệnh sau khi khởi động lại shell:
# p10k configure

# SSH Agent
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"
ssh-add -q ~/.ssh/id_ed25519 2>/dev/null
