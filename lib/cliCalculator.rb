require "optparse"
require "cliCalculator/exceptions"
require "cliCalculator/calculations"

class Parser

  def parse_options
    options = {}

    optparse = OptionParser.new do |opts|
      opts.banner = "Usage: cliCalculator [options] [argument]"

      opts.on("-c", "--calculate 'COMMMAND'", "Calculates the result of argument") do |c|
        options[:command] = true
        options[:command_content] = c
      end

      opts.on( "-v", "--version", "Prints version" ) do
        puts CliCalculator::VERSION
        exit
      end

      opts.on( "-h", "--help", "Prints help guide" ) do
        puts opts
        exit
      end

    end

    begin
      optparse.parse!
      if !ARGV.empty?
        raise OptionParser::InvalidOption
      end  
      options[:command_content] = Calculations.validate_input( options[:command_content] )
      options[:command_content] = Calculations.calculate_input( options[:command_content] )
      Calculations.display_output( options[:command_content] )
    rescue OptionParser::MissingArgument
      puts "Please enter an argument to calculate with the -c flag"
    rescue OptionParser::InvalidOption
      puts "Please enter a valid flag. Enter 'cliCalculator --help' to see options."
    rescue InvalidInput => e
      puts e.message
    rescue MissingParenthesis => e
      puts e.message
    end

  end

end
