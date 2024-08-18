echo "=====\nInstalling xcode-select\n====="
xcode-select –-install

echo "=====\nDo we have brew installed?\n====="
which -s brew
if [[ $? != 0 ]] ; then
  # Install Homebrew
  echo "Nope. Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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

echo "=====\nInstalling Ruby\n====="
ruby-install 3.2.2

echo "=====\nInitialising dot files\n====="
./setup_dot_files.sh
