require 'bundler'
require "sinatra/activerecord"
require "readline"

Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.sqlite3')
ActiveRecord::Base.logger = nil

require_all 'lib'
