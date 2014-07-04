module StructuredSearch

  class LexicalError < StandardError
  end

  class SyntaxError < StandardError
  end

  # raised when a provider is referenced, but no provider
  # class is given to the evaluator
  class UnregisteredProviderError < StandardError
  end

  # raised when a provider does not have a method required
  # by StructuredSearch (e.g. doesn't respond to search() etc.)
  class ProviderNotAvailableError < StandardError
  end
end
