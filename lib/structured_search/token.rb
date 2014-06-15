module StructuredSearch

  class Token
    attr_accessor :token, :lexeme, :column, :line

    def initialize(tok = {})
      #send val to key setter
      tok.each do |k, v|
        send "#{k}=", v
      end
    end

    def to_s
      "#{@token}: '#{@lexeme}' (Line #{@line}, Column #{@column})"
    end
  end

end

