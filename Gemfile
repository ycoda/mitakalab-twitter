# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem "rails", '~>5.2.0'
gem 'haml-rails'
gem 'turbolinks'

group :development, :test do
  gem 'rspec-rails'
  gem 'faker'
  gem 'spring'

  gem 'pry-rails'
  gem 'pry-byebug' # デバッグを実施(Ruby 2.0以降で動作する)
  gem 'pry-stack_explorer' # スタックをたどれる
  gem 'pry-coolline'
  gem 'awesome_print'
  gem 'hirb'
  gem 'hirb-unicode'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'seed-fu'
  gem 'meta_request' # chrome developer tool でリクエスト内容を見れるようになる
  gem 'bootsnap'
  gem 'sqlite3'
  gem 'listen'
end
