require 'structured_search/token'

module StructuredSearch
  
  class Lexer
    attr_accessor :input, :column, :line, :lexer_offset

    def state
      { input: input, column: column, line: line }
    end

    def state=(state)
      @input = state[:input]
      @column = state[:column]
      @line = state[:line]
    end

    def initialize(input)
      @input = input
      @column = 1
      @line = 1
      @lexer_offset = 0
    end

    def scan(is_peek = false)
      PATTERNS.each do |pattern|
        match = pattern[1].match(@input, @lexer_offset)
        if match
          token_data = { token: match[0], lexeme: match[2], line: @line, column: @column }
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

          return token
        end
      end

      # have we underrun the input due to lex error?:
      raise LexicalError if @lexer_offset < @input.size
      nil
    end

  end
end



