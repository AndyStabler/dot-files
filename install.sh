echo "=====\nInstalling xcode-select\n====="
xcode-select –-install

echo "=====\nDo we have brew installed?\n====="
which -s brew
if [[ $? != 0 ]] ; then
  # Install Homebrew
  echo "Nope. Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/andy/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Yep. Updating homebrew..."
  brew update
fi

echo "=====\nInstalling brew files\n====="
brew bundle

# This was failing because a cask was already installed. If that happens
# let's bomb out so we can investigate before continuing.
if [[ $? != 0 ]]; then
  echo "BrewFile failed :("
  exit -1
fi

echo "====\nInstalling ohmyzsh\n====="
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install vundle for vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install pathogen for vim
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

echo "=====\nInstalling Ruby\n====="
ruby-install 3.2.2

echo "=====\nInitialising dot files\n====="
./setup_dot_files.sh
