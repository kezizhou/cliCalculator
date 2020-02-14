class MissingParenthesis < StandardError

    def initialize( msg = "Please make sure each (, [, or { has a matching closing parenthesis." )
      super( msg )
    end

end

class InvalidInput < StandardError

  def initialize( msg = "Please enter only numeric digits or *, /, +, -" )
    super( msg )
  end

end