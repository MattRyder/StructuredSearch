module StructuredSearch

  class Parser

    # stores all parse tree nodes
    attr_reader :nodes

    def initialize(lexer)
      @lexer = lexer
      @nodes = []
    end

    # read the next token in the stream
    def read_token
      @lexer.scan
    end

    # peek at the next token in stream
    def peek_token
      @lexer.scan(true)
    end

    def parse_to_end
      while peek_token
        new_node = parse
        nodes << new_node if new_node
      end
    end

    def parse
      @current_token = read_token
      
      case @current_token.token
      when :WHITESPACE; when :SEMICOLON; return
      else; send "new_#{@current_token.token.downcase}"
      end
    end

    def basic_options
      { line: @current_token.line, column: @current_token.column }
    end

    def new_select
      Tree::Select.new(basic_options)
    end

    def new_asterisk
      Tree::Asterisk.new(basic_options)
    end

    def new_from
      Tree::From.new(basic_options)
    end

    def new_string
      Tree::String.new(basic_options)
    end


    
  end
end
