#!/bin/bash
#setup GOPATH
            echo "setup GOPATH 1,2,3" 
            echo 'GOPATH="$HOME/go"' >> $HOME/.profile
            echo 'PATH="$GOPATH/bin:$PATH"' >> $HOME/.profile
            echo 'PATH="$PATH:/usr/local/go/bin"' >> $HOME/.profile
            source $HOME/.profile

       command -v go &> /dev/null
        if [ $? -ne 0 ]

            then
            echo "GO aka Goland is not installed, preparing for install GO and setup the GOPATH"
            sudo apt-get update
            echo "Installing go now, visit https://golang.org/ for more info"
            wget https://golang.org/dl/go1.17.3.linux-amd64.tar.gz 
            sudo tar -C /usr/local -xzf go1.15.linux-amd64.tar.gz
            
            go version
        else
            echo    "go is already installed on your system, skipping goland installation"
        fi
