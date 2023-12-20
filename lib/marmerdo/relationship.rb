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

    # @return [Array<Symbol>]
    attr_reader :to

    def self.valid_type?(type)
      TYPES.include?(type.to_sym)
    end

    def initialize(type:, to:)
      @type = type.to_sym
      @to = if to.is_a?(Array)
              to.map(&:to_sym)
            else
              [to.to_sym]
            end
    end

    def to_mermaid_str(from)
      to.map do |t|
        case type
        when :inheritance
          "#{t} <|-- #{from}"
        when :composition
          "#{t} *-- #{from}"
        when :aggregation
          "#{t} o-- #{from}"
        when :association
          "#{from} --> #{t}"
        when :link_solid
          "#{from} -- #{t}"
        when :dependency
          "#{from} ..> #{t}"
        when :realization
          "#{from} ..|> #{t}"
        when :link_dashed
          "#{from} .. #{t}"
        else
          raise UnknownRelationshipType
        end
      end.join("\n")
    end
  end
end
