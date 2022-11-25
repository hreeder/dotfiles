#!/usr/bin/env bash
xc_tools_path=$(xcode-select -p)
xc_tools_status=$?
if [[ $xc_tools_status -ne 0 ]]; then
    xcode-select --install
    read -n1 -p "💻 Press enter once the Xcode Tools installation has finished. " continue_keypress
fi

if [ ! -d "/opt/homebrew" ]; then
    echo "🍺 Installing Homebrew "
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if ! command -v pipx &> /dev/null; then
    echo "🐍 Installing pipx"
    brew install pipx
    pipx ensurepath
fi

if ! command -v ansible &> /dev/null; then
    echo "🐍 Installing Ansible"
    pipx install --include-deps ansible
fi

[ ! -d "~/dev/personal" ] && mkdir -p ~/dev/personal
[ ! -d "~/dev/personal/dotfiles" ] && git clone https://github.com/hreeder/dotfiles.git ~/dev/personal/dotfiles

pushd ~/dev/personal/dotfiles/ansible
ansible-galaxy install -r requirements.yml
ansible-playbook main.yml
popd