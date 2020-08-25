# frozen_string_literal: true

module RoboTop
  # Module containing all of the various commands that may be issued to a {Robot}. New
  # commands should be introduced by adding a new sub-class of {Command} and defining
  # a corresponding method in {Robot}.
  module Commands
    require 'robo_top/commands/parser'
    require 'robo_top/commands/command'
    require 'robo_top/commands/left_command'
    require 'robo_top/commands/right_command'
    require 'robo_top/commands/move_command'
    require 'robo_top/commands/report_command'
    require 'robo_top/commands/place_command'
    require 'robo_top/commands/null_command'
  end
end
