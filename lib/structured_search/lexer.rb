require 'structured_search/token'
require 'structured_search/errors'

module StructuredSearch

  # Converts the input into a token stream, that can be worked 
  # by the syntax parser.
  class Lexer

    # +input+:: Input string to parse
    # +column+:: Current column position
    # +line+:: Current position in the line
    # +lexer_offset+:: Current character position in the input string
    attr_accessor :input, :column, :line, :lexer_offset

    # Returns the current state of the lexer, by way of input, 
    # current line and column.
    def state
      { input: input, column: column, line: line }
    end

    # Sets the state of the lexer
    def state=(state)
      @input = state[:input]
      @column = state[:column]
      @line = state[:line]
    end

    # Creates a new instance of the Lexer.
    # Params:
    # +input+:: The SQL input that will be parsed.
    def initialize(input)
      @input = input
      @column = 1
      @line = 1
      @lexer_offset = 0
    end

    # Scans the input, matching each token that appears and 
    # returns the token. Supports both read and peek operations
    # determined by the state of the peek flag.
    # Params:
    # +is_peek+:: Whether the lexer will consume the token, or 
    #             remain in it's current position (false by default)
    # Returns:
    # +token+:: A StructuredSeach::Token is returned to the caller.
    def scan(is_peek = false)
      PATTERNS.each do |pattern|
        match = pattern[1].match(@input, @lexer_offset)
        if match
          token_data = { token:  pattern[0],
                         lexeme: pattern[2] ? pattern[2].call(match) : '',
                         line: @line, column: @column }
          token = Token.new(token_data)

          # increment line and col position if a read op:
          if !is_peek
            tok_length = match[0].size
            newline_count = match[0].count("\n")
            @lexer_offset += tok_length
            @line += newline_count
            @column = 1 if newline_count
            @column += tok_length - (match[0].rindex("\n") || 0)
          end

          # clear any whitespace
          if pattern[0] == :WHITESPACE
            @lexer_offset += match[0].size
            return scan(is_peek)
          else
            return token
          end

        end
      end

      # have we underrun the input due to lex error?:
      if @lexer_offset < @input.size
        raise LexicalError, "Unexpected character \"#{@input[@lexer_offset+1]}\"  at (Line #{@line}, Column #{@column})"
      end

      nil
    end

  end
end



