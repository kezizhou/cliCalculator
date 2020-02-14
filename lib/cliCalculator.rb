require "optparse"
require "cliCalculator/exceptions"

module CliCalculator
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
        options[:command_content] = validate_input( options[:command_content] )
        options[:command_content] = calculate_input( options[:command_content] )
        display_output( options[:command_content] )
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


    PAREN_PAIRS = {
      "(" => ")",
      "{" => "}",
      "[" => "]"
    }

    OPEN_PARENS = PAREN_PAIRS.keys
    CLOSE_PARENS = PAREN_PAIRS.values

    OPERATIONS = ["+", "-", "/", "*"]

    def validate_input(input)
      # Remove all newline characters (space, newline, tab)
      input = input.gsub(/\s+/, "")

      # Use a stack to check for matching parentheses sets
      paren_stack = []

      # Check each character of the string
      input.each_char do |char|
        # Open parenthesis
        if OPEN_PARENS.include?(char)
          # Push open parenthesis to stack
          paren_stack << char
        # Last open parenthesis' matching closing parenthesis
        elsif CLOSE_PARENS.include?(char)
          # If yes, pop the last item
          if char == PAREN_PAIRS[paren_stack.last]
            paren_stack.pop
          else
            raise MissingParenthesis
          end
        # Is a number 0-9
        elsif char =~ /\d/
          
        # Is an operation
        elsif OPERATIONS.include?(char)

        else
          raise InvalidInput
        end
      end

      # Check if there are any leftover extra parentheses after all characters have been processed
      if !paren_stack.empty?
        raise MissingParenthesis
      end

      return input
    end


    def calculate_input(validated_input)
      calculated_output = eval(validated_input)
      # TODO: Currently does not work with {}
    end


    def display_output(calculated_output)
      puts calculated_output
    end

  end

end
