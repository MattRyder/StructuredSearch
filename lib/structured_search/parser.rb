module StructuredSearch

  class Parser

    def initialize(lexer)
      @lexer = lexer
    end

    # read the next token in the stream
    def read_token
      @lexer.scan
    end

    # peek at the next token in stream
    def peek_token
      @lexer.scan(true)
    end

    def parse
      token_type = peek_token.type
      
      case token_type
      when :SELECT; send :select
    end


  end
end
