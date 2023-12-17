require "front_matter_parser"
require_relative "node"
require_relative "relationship"

module Marmerdo
  class MarkdownParser
    def initialize(name, content)
      @name = name
      @content = content
    end

    # @return [Node]
    def parse
      Node.new(
        name: front_matter["name"] || @name,
        namespace: front_matter["namespace"],
        relationships: relationships
      )
    end

    private

    def front_matter
      @front_matter ||= FrontMatterParser::Parser.new(:md).call(@content).front_matter["marmerdo"]
    end

    def relationships
      @relationships ||= front_matter.filter { |k, _| Relationship::TYPES.include?(k.to_sym) }.map do |type, to|
        Relationship.new(type: type, to: to)
      end
    end
  end
end
