require 'structured_search/token'
require 'structured_search/errors'

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



