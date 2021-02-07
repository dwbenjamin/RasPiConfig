# frozen_string_literal: true

require 'thor'

module RasPiConfig
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'RasPiConfig version'
    def version
      require_relative 'version'
      puts "v#{RasPiConfig::VERSION}"
    end
    map %w(--version -v) => :version

    desc 'spi ACTION', 'Command description...'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def spi(action)
      if options[:help]
        invoke :help, ['spi']
      else
        require_relative 'commands/spi'
        RasPiConfig::Commands::Spi.new(action, options).execute
      end
    end
  end
end
