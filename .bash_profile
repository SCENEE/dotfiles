# env
export EDITOR=vim
export TERM="xterm-256color"

export LANG=en_US.UTF-8
export LC_CTYPE=UTF-8
export LC_ALL=en_US.UTF-8
export IGNOREEOF=3

if [ ! -z $BASH_VERSION ]; then
	export PS1="[\u@\h \W]\$ "
elif [ ! -z $ZSH_VERSION ]; then
	export PS1="[${USER}@${HOST%%.*} %1~]%(!.#.$) "
fi
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

## undefine Ctrl-S for i-search
stty stop undef

###############
# Aliases (custom)
alias ..='cd ..'
alias cp="cp -i"
alias t="tmux"
alias rm="rm -id"
alias x="xargs"

if [ "$(uname)" = 'Darwin' ];
then
alias ls='ls -GpF' # Mac OSX specific
alias ll='ls -alGpF' # Mac OSX specific
alias o="open "
alias getplain='pbpaste | pbcopy'
else
alias ll="ls -AlFh"
alias ls="ls -F"
fi

alias v="vim"
alias vi="vim" # Use vim installed by brew

###############
# less
export LESS='-g -i -R -z-4 -x4'
export PAGER=less
if which lesspipe.sh > /dev/null; then
	export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi

###############
# svn
export SVN_EDITOR=vim

###############
# git
if [ ! -z $BASH_VERSION ] ; then
  source ~/.git-completion.bash
fi


## rbenv ##
>/dev/null which rbenv \
	&& export PATH=~/.rbenv/shims:$PATH \
	&& eval "$(rbenv init -)" \
	&& PATH="~/.rbenv/shims:$PATH"

## gvm ##
#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/shin.yamamoto/.gvm/bin/gvm-init.sh" ]] \
	&& source "/Users/shin.yamamoto/.gvm/bin/gvm-init.sh"

## pyenv ##
[ "$(uname)" = 'Darwin' ] \
	&& export PYTHON_CONFIGURE_OPTS="--enable-framework CC=clang"
> /dev/null which pyenv \
	&& export PYENV_ROOT="$HOME/.pyenv" \
	&& export PATH="$PYENV_ROOT/bin:$PATH" \
	&& export VIRTUALENVWRAPPER_PYTHON="$PYENV_ROOT/shims/python" \
	&& eval "$(pyenv init -)" \
	&& eval "$(pip completion --bash)"

## swiftenv ##
>/dev/null which swiftenv \
	&& eval "$(swiftenv init -)"

## postgresql ##
>/dev/null which psql \
	&& export PGDATA=/usr/local/var/postgres

## nodebrew ##
>/dev/null which nodebrew \
	&& export PATH=$HOME/.nodebrew/current/bin:$PATH

## go ##
>/dev/null which go \
	&& export GOPATH=$HOME/.go \
	&& export PATH=$PATH:/usr/local/opt/go/libexec/bin:$GOPATH/bin

## haskell-stack ##
>/dev/null which stack \
	&& export PATH="$HOME/.local/bin:$PATH"

## peco ##

if >/dev/null which peco; then
	peco-select-history() {
		declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")
		READLINE_LINE="$l"
		READLINE_POINT=${#l}
	}
	bind -x '"\C-r": peco-select-history'
fi

# macOS
if [ "$(uname)" = 'Darwin' ];
then
	if [ -r ~/.bash_private ]; then
		source ~/.bash_private
	else
		echo "Not found .bash_private"
	fi

	function empty-trash () {
		if [ -z "$(ls -A ~/.Trash/)" ]; then
			echo "Trash is empty"
		else
			osascript -e 'tell app "Finder" to empty'
		fi
	}

	function shutdown-applescript () {
		osascript -e 'tell app "loginwindow" to «event aevtrsdn»'
	}

	## brew ##
	if which brew > /dev/null;
	then
		if [ -f $(brew --prefix)/etc/bash_completion ]; then
			. $(brew --prefix)/etc/bash_completion
		fi
		# WARN:  Please set HOMEBREW_GITHUB_API_TOKEN in ~/.bashrc
		alias ctags="`brew --prefix`/bin/ctags"
	fi

	## dropbox ##
	if test -d /Applications/Dropbox.app;
	then
		DROPBOX_PATH=~/Dropbox
		function mnt_kv() {
			$DROPBOX_PATH/EncryptedData/mnt_keyvault
		}

		function umnt_kv() {
			$DROPBOX_PATH/EncryptedData/umnt_keyvault
		}
	fi

	## relax ##
	which relax > /dev/null && source "$(relax init completion)"

	## anaconda ##
	if test -d  ~/anaconda*;
	then
		function activate_anaconda() {
			# added by Anaconda3 4.0.0 installer
			PATH0="$PATH"
			export PATH="/Users/syamamoto/anaconda3/bin:$PATH"
		} 

		function deactivate_anaconda() {
			if test ${PATH0:-undefined} != undefined; then
				export PATH="$PATH0"
			fi
		}
	fi

	## octave ##
	if which octave > /dev/null;
	then
		## To define a plot application
		export GNUTERM=x11
	fi

	## iTerm ##
	tt ()  { 
		echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print "/"$1"/"$2}'| rev)\007"
	}

	## Fix OpenSSL version for macOS ##
	if [ -d /usr/local/opt/openssl ]; then
		export PATH=/usr/local/opt/openssl/bin:$PATH
		export LD_LIBRARY_PATH=/usr/local/opt/openssl/lib:$LD_LIBRARY_PATH
		export CPATH=/usr/local/opt/openssl/include:$LD_LIBRARY_PATH
	fi

	### gettext ###
	export PATH="/usr/local/opt/gettext/bin:$PATH"

	## Travis CI ##
	[ -f /Users/syamamoto/.travis/travis.sh ] && source /Users/syamamoto/.travis/travis.sh
fi

[ -r ~/.bashrc ] && source ~/.bashrc
