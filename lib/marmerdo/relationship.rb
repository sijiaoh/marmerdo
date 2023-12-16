module Marmerdo
  class Relationship
    TYPES = %i[
      inheritance
      composition
      aggregation
      association
      link_solid
      dependency
      realization
      link_dashed
    ].freeze

    # https://mermaid.js.org/syntax/classDiagram.html#defining-relationship
    # | Type    | Description   |
    # | ------- | ------------- |
    # | `<\|--` | Inheritance   |
    # | `*--`   | Composition   |
    # | `o--`   | Aggregation   |
    # | `-->`   | Association   |
    # | `--`    | Link (Solid)  |
    # | `..>`   | Dependency    |
    # | `..\|>` | Realization   |
    # | `..`    | Link (Dashed) |
    # @return [Symbol]
    attr_reader :type

    # @return [Symbol]
    attr_reader :to

    def self.valid_type?(type)
      TYPES.include?(type.to_sym)
    end

    def initialize(type:, to:)
      @type = type.to_sym
      @to = to.to_sym
    end
  end
end
