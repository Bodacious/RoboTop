# frozen_string_literal: true

module RoboTop
  ##
  # Include in classes to provide debug logging
  module Logging
    require 'logger'
    require 'fileutils'

    ##
    # Name of the directory where log files are kept
    DIR_NAME = './log'

    ##
    # Name of the logger file
    FILE_NAME = 'output.log'

    private

    def log(message)
      logger.info(message) if ENV['LOGGING']
    end

    # Logger object that debugging info is written to if `--debug` flag is used.
    def logger
      FileUtils.mkdir_p(DIR_NAME)
      Logger.new(File.join(DIR_NAME, FILE_NAME), Logger::DEBUG)
    end
  end
end
