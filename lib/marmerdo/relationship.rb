require_relative "error"

module Marmerdo
  class Relationship
    class UnknownRelationshipType < Error; end

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

    def to_mermaid_line(from)
      case type
      when :inheritance
        "#{to} <|-- #{from}"
      when :composition
        "#{to} *-- #{from}"
      when :aggregation
        "#{to} o-- #{from}"
      when :association
        "#{from} --> #{to}"
      when :link_solid
        "#{from} -- #{to}"
      when :dependency
        "#{from} ..> #{to}"
      when :realization
        "#{from} ..|> #{to}"
      when :link_dashed
        "#{from} .. #{to}"
      else
        raise UnknownRelationshipType
      end
    end
  end
end
