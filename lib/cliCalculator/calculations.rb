require "pry"

class Calculations

    PAREN_PAIRS = {
        "(" => ")",
        "{" => "}",
        "[" => "]"
    }

    OPEN_PARENS = PAREN_PAIRS.keys
    CLOSE_PARENS = PAREN_PAIRS.values

    OPERATIONS = ["+", "-", "/", "*"]

    def self.validate_input(input)
        # Remove all newline characters (space, newline, tab)
        input = input.gsub(/\s+/, "")

        # Use a stack to check for matching parentheses sets
        paren_stack = []

        # Stacks to convert infix to postfix
        output_stack = []
        operator_stack = []

        # Check each character of the string
        input.each_char do |char|

            # Open parenthesis
            if OPEN_PARENS.include?(char)
                # Push to stack
                paren_stack << char
                operator_stack << char
                
            # Last open parenthesis' matching closing parenthesis
            elsif CLOSE_PARENS.include?(char)
                # If yes, pop the last parenthesis
                if char == PAREN_PAIRS[paren_stack.last]
                    paren_stack.pop
                else
                    raise MissingParenthesis
                end

                until OPEN_PARENS.include?(operator_stack.last)
                    output_stack << operator_stack.pop
                end
                if !operator_stack.empty?
                    output_stack << operator_stack.each
                end
            # Is a number 0-9
            elsif char =~ /\d/
                output_stack << char
            
            # Is an operation
            elsif OPERATIONS.include?(char)
                while !operator_stack.empty? && !OPEN_PARENS.include?(operator_stack.last)
                    if operator_priority(operator_stack.last) > operator_priority(char) || ( operator_priority(operator_stack.last) == operator_priority(char) )
                        output_stack << operator_stack.pop
                    end
                end
                operator_stack << char
            else
                raise InvalidInput
            end

        end

        # Check if there are any leftover extra parentheses after all characters have been processed
        if !paren_stack.empty?
            raise MissingParenthesis
        end

        binding.pry
        return input
    end


    def self.calculate_input(converted_input)
        calculated_output = eval(converted_input)
        # TODO: Change without using eval
    end


    def self.display_output(calculated_output)
        puts calculated_output
    end


    def self.operator_priority(operator)
        case operator
        when "+"
            return 1
        when "-"
            return 1
        when "/"
            return 2
        when "*"
            return 2
        end
    end

end