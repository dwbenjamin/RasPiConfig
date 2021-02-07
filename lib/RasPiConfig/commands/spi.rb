# frozen_string_literal: true

require_relative '../command'

module RasPiConfig
  module Commands
    class Spi < RasPiConfig::Command
      def initialize(action, options)
        @action = action
        @options = options
      end

      def extraconfig(action)
        def file_write
          File.write('/boot/efi/extraconfig.txt', "# Enable SPI access from Linux\ndtparam=spi=on\n")
        end

        exist = false
        if action == 'enable'
          if File.file?('/boot/efi/extraconfig.txt')
            File.open('/boot/efi/extraconfig.txt', 'r') do |file|
              file.each { |line|
                if line.include?('spi')
                  exist=true
                end
              }
              end
            end
            unless exist 
              file_write
            end
        else
          file_write
        end

        if action == 'disable'
          if File.file?('/boot/efi/extraconfig.txt')
            File.open('/boot/efi/extraconfig.txt', 'r') do |file|
              file.each { |line|
                if line.include?('spi')
                  exist=true
                end
              }
            end
          end
          if exist
            system("sed -i '/spi\|SPI/d' /boot/efi/extraconfig.txt")
          end
        end
      end

      def enable
        unless File.file?('/etc/modules-load.d/10-spi.conf')
          File.write('/etc/modules-load.d/10-spi.conf', "# Load spidev.ko\nspidev\n")
        end
        extraconfig(@action)
        system('modprobe spidev')
      end

      def disable
        if File.file?('/etc/modules-load.d/10-spi.conf')
          File.delete('/etc/modules-load.d/10-spi.conf')
        end
        system('rmmod spidev')
      end

      def execute(input: $stdin, output: $stdout)
        case @action
        when 'enable'
          enable
        when 'disable'
          disable
        else
          puts "#{@action} is not not correct.  ACTION should be [enable|disable]"
        end
      end
    end
  end
end
