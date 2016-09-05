#!/usr/bin/env ruby

# Load Rails
ENV['RAILS_ENV'] = ARGV[0] || 'development'
DIR = File.dirname(__FILE__)
require_relative 'environment'

# Analyse every engines
Season.engines.each do |engine|
  # Does the engine define a schedule file?
  if engine.has_schedule?
    # Schedule file
    file = engine.schedule_path
    # Load schedule file
    instance_eval File.read(file), file
  end
end
