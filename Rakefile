# frozen_string_literal: true

require_relative 'config/application'

Rails.application.load_tasks

if %w[development test].include? Rails.env
  require 'rubocop/rake_task'
  require 'cucumber'
  require 'cucumber/rake/task'
  RuboCop::RakeTask.new
  task(:default).clear
  task default: %i[rubocop spec cucumber]
end
