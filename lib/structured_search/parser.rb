module StructuredSearch

  # Parses a token stream, returning an array of StructuredSearch::Statement
  class Parser

    # stores all parse tree nodes
    attr_reader :statements, :providers

    # Creates a new instance of the Parser, taking a Lexer and a hash of
    # providers (An identifier and class that contains the search method)
    # Params:
    # +lexer+:: A StructuredSearch::Lexer object
    # +providers+:: A Hash of provider names and their classes 
    def initialize(input, providers)
      @lexer = StructuredSearch::Lexer.new(input)
      @providers = Hash.new
      providers.each { |k,v| @providers[k.downcase] = v }
      
      @nodes, @statements = [], []
    end

    # Reads the next token in the stream
    def read_token
      @lexer.scan
    end

    # Peeks at the next token in stream
    def peek_token
      @lexer.scan(true)
    end

    # Parses the token stream into statements until there
    # are no more tokens left
    def parse_to_end
      while peek_token
        new_node = parse
        @nodes << new_node if new_node
      end

      # flush token stream to a statement if no semicolon
      new_statement if @nodes.length > 0
    end

    # Parses the next token in the token stream into an AST node
    # Returns an AST node
    def parse
      @current_token = read_token
      
      case @current_token.token
        when :SEMICOLON
          new_statement
        else
          send "new_#{@current_token.token.downcase}"
      end
    end

    # Basic options given to BaseNode when creating a new instance
    # of a node, including the line, column and type
    def basic_options
      { line: @current_token.line, column: @current_token.column, type: @current_token.token }
    end

private

    # Creates a new Tree::Select
    def new_select
      quant_list = [ :ALL, :DISTINCT ]
      select_list = [ :ASTERISK, :STRING ]

      select_tok = Tree::Select.new(basic_options)

      # handle an optional set quantifier (ALL or DISTINCT)
      if quant_list.include? peek_token.token
        select_tok.set_quantifier = read_token.token
      end

      # handle a select list (ASTERISK or search terms)
      if select_list.include? peek_token.token

        # read in all search terms from the query:
        while peek_token.token == :STRING
          select_tok.add_search_term(read_token.lexeme)
          read_token if peek_token.token == :COMMA
        end

      else
        raise SyntaxError "No valid select list given (#{error_location})"
      end
      
      select_tok
    end

    # Creates a new Tree::From
    def new_from
      source_tokens = [ :STRING ]
      from_tok = Tree::From.new(basic_options)

      # read in all the derived columns - search sources:
      while peek_token and source_tokens.include? peek_token.token
        src_token = read_token
        # check if the provider is registered in the given list:
        if provider_exists? src_token.lexeme.downcase
          from_tok.sources[src_token.lexeme] = @providers[src_token.lexeme.downcase.to_sym]
        else raise UnregisteredProviderError, "#{src_token.lexeme} is not a registered provider"
        end
      end

      if from_tok.sources.count == 0
        raise SyntaxError, "No search sources given (#{error_location})"
      end

      from_tok
    end

    # Creates a new Tree::Statement
    def new_statement
      @statements.push Tree::Statement.new(@nodes)
      @nodes = [] # reset node array
      nil
    end

    # Checks whether a search provider class exists
    def provider_exists?(source)
      @providers.has_key? source.to_sym
    end

    # Returns a string that will inform the user where an error
    # has occurred.
    def error_location
      "Line #{basic_options[:line]}, Column #{basic_options[:column]}"
    end
    
  end
end
