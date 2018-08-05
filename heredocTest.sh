#!/usr/bin/env bash

ANTLR_HOME=$HOME/lib/java
cat << EOF | cat > ~/tmp/.bashrc
alias antlr4='java -jar \$ANTLR_HOME\\\\antlr-4.7-complete.jar'
alias grun='java org.antlr.v4.gui.TestRig'
EOF
