# frozen_string_literal: true

require 'bundler'

Bundler.require

Dir['./lib/*.rb'].each { |file| require file }
Dir['./app/models/*.rb'].each { |file| require file }
Dir['./app/services/*.rb'].each { |file| require file }
