require_relative '../app'

require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
Dir.glob("spec/acceptance/steps/*steps.rb") { |f| load f, true }


def app
  Sinatra::Application
end
Capybara.app = app

def extract_words_from comma_separated_words
  comma_separated_words.split(',').map(&:strip)
end

def main_page_path
  '/'
end

def activity_path activity
  "/activity/#{activity.id}"
end

def the purpose_name
  "[data-purpose=#{purpose_name}]"
end