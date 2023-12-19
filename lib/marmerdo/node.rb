module Marmerdo
  class Node
    # @return [Symbol]
    attr_reader :path
    # @return [Symbol]
    attr_reader :name
    attr_accessor :relationships

    def initialize(path:, name:, relationships:)
      @path = path
      @name = name.to_sym
      @relationships = relationships
    end

    def to_mermaid_line
      "class #{name}"
    end
  end
end
