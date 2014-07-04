module StructuredSearch

  # Raised when an error occurs during lexical analysis, 
  # such as an incorrect character in the input
  class LexicalError < StandardError
  end

  # Raised when an error occurs during parsing, such as 
  # an invalid token in the stream (FROM before a SELECT etc.)
  class SyntaxError < StandardError
  end

  # Raised when a provider is referenced, but no provider
  # class is given to the evaluator
  class UnregisteredProviderError < StandardError
  end

  # Raised when a provider does not have a method required
  # by StructuredSearch (e.g. doesn't respond to search() etc.)
  class ProviderNotAvailableError < StandardError
  end
end
