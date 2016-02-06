# Set up personal aliases
export BASE_DIR=~/projects
export TEST_DIR=~/test_code

# General
alias goconfig='pushd $CONFIG_DIR > /dev/null'

# Base project directories
alias goproj='pushd $BASE_DIR > /dev/null'
alias gopy='pushd $BASE_DIR/py > /dev/null'
alias gocpp='pushd $BASE_DIR/cpp > /dev/null'

# Test directories
alias gotst='pushd $TEST_DIR > /dev/null'
alias gopyt='pushd $TEST_DIR_DIR/py > /dev/null'
alias gocppt='pushd $TEST_DIR/cpp > /dev/null'

# Binary files
alias gobin='pushd ~/bin > /dev/null'
alias cleanbin='rm ~/bin/*'

# Python
alias py='/usr/bin/python'
alias ipy='/usr/bin/ipython'

# Ctags
export CTAGS_DIR=$BASE_DIR
alias rctags='cd $BASE_DIR && /usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q $BASE_DIR'

# Misc
alias refresh='source ~/.bashrc'
