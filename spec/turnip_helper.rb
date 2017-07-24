require 'rails_helper'
require 'turnip'
require 'turnip/capybara'

Dir.glob('spec/steps/**/*_steps.rb') { |f| load f, true }

