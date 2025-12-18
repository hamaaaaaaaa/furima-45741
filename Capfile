# Capistrano の基本セットアップ
require "capistrano/setup"

# Deploy 関連
require "capistrano/deploy"

# Git SCM を明示的に指定（必須）
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Ruby 環境、Bundler、Rails など
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano3/unicorn'

# 自作タスクを読み込み
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
