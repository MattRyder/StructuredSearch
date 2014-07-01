module StructuredSearch

  class LexicalError < StandardError
  end

  class SyntaxError < StandardError
  end

  # raised when a provider is referenced, but no provider
  # class is given to the evaluator
  class UnregisteredProviderError < StandardError
  end

end
