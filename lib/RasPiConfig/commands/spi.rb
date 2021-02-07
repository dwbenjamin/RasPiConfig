# frozen_string_literal: true

require_relative '../command'

module RasPiConfig
  module Commands
    class Spi < RasPiConfig::Command
      def initialize(action, options)
        @action = action
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        # Command logic goes here ...
        output.puts "OK"
      end
    end
  end
end
