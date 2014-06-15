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

    def scan
      PATTERNS.each do |pattern|
        match = pattern[1].match(@input, @lexer_offset)
        byebug
        if match
          token_data = { token: match[0], lexeme: match[2], line: @line, column: @column }
          token = Token.new(token_data)
          @lexer_offset += match[0].size
          return token
        end
      end
    end

  end
end



