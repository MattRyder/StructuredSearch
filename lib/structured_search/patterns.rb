module StructuredSearch

  class Lexer
    
    # SQL reserved words
    RESERVED = %w{ SELECT FROM WHERE ALL AND ASC BOTH }

    # pattern hash of token keys and regex values
    PATTERNS = [
      # intern reserved words and their patterns
      *RESERVED.map { |rw| [rw.intern, /#{rw}(?=[^A-z0-9_])/] },
      
      # match sgl/dbl quoted strings
      [:STRING, /(['"])(\\n|\\.|((?!\1)(?!\\)|.)*?((?!\1)(?!\\).)?)\1/, -> match { match[2] } ],
      [:L_PAREN,    /\(/],
      [:R_PAREN,    /\)/],
      [:L_BRACKET,  /\[/],
      [:R_BRACKET,  /\]/],
      [:L_BRACE,    /\{/],
      [:R_BRACE,    /\}/],
      [:PERCENT,    /%/ ],
      [:AMPERSAND,  /&/ ],
      [:ASTERISK,   /\*/],
      [:PLUS,       /\+/],
      [:MINUS,      /-/],
      [:COMMA,      /,/ ],
      [:PERIOD,     /\./],
      [:COLON,      /:/ ],
      [:SEMICOLON,  /;/ ],
      [:LEQ,        /<=/],
      [:EQUALS,     /=/ ],
      [:GEQ,        />=/],
      [:QUESTION,   /\?/],
      [:CIRCUMFLEX, /\^/],
      [:UNDERSCORE, /_/ ],
      [:PIPE,       /\|/]
    ].map { |pattern| [pattern[0], /#{pattern[1]}/, pattern[2]] }
  end
end
