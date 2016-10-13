# vim-plugin
Plugin manager for Pathogen.

## Installation

Clone the repo and add it to your $PATH.

## Usage

Supports following functions:

- `install <repo>`: installs plugin to ~/.vim/bundle from specified GitHub repository.  
  Usage example: `vim-plugin install godlygeek/tabular`
- `remove <repo>`: removes plugin installed by `vim-plugin`. The plugin must have an information file.

## Information files

A vim-plugin information file is a JSON dump of a GitHub API request. All information about the plugin is stored there.

## Modifications

`vim-plugin` is written in Ruby. It is licensed under the MIT license.

If you want to add something, please make a pull request.
