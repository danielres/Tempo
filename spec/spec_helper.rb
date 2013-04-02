require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
require_relative '../app'
Dir.glob("spec/acceptance/steps/*steps.rb") { |f| load f, true }


def app
  Sinatra::Application
end
Capybara.app = app

def extract_words_from comma_separated_words
  comma_separated_words.split(',').map(&:strip)
end