module Marmerdo
  class Node
    # @return [Symbol, nil]
    attr_reader :name
    # @return [Symbol, nil]
    attr_reader :namespace
    attr_accessor :relationships

    def initialize(name:, namespace:, relationships:)
      @name = name&.to_sym
      @namespace = namespace&.to_sym
      @relationships = relationships
    end

    def to_mermaid_line
      "class #{name}"
    end
  end
end
