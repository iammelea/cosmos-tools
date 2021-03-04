#!/bin/bash
       command -v pm2 &> /dev/null
        if [ $? -ne 0 ]

            then
            echo "PM2 is not installed, preparing for install or update: nvm, nodes, npm, pm2"
            sudo apt-get update && sudo apt install build-essential jq -y
            echo "Installing nvm nodes npm pm2"
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
            export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
            [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
                source $HOME/.profile
                nvm install node && nvm use node && npm install pm2 -g && pm2 completion install
            source $HOME/.profile
        else
            echo    "pm2 is already installed on your system, skipping pm2 installation"

        fi
