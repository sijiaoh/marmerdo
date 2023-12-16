require "front_matter_parser"
require_relative "node"
require_relative "relationship"

module Marmerdo
  class MarkdownParser
    # @param [String] content
    # @return [Node]
    def parse(name, content)
      front_matter = FrontMatterParser::Parser.new(:md).call(content).front_matter

      node = Node.new(name: name, namespace: front_matter["namespace"])
      node.relationships = generate_relationships(front_matter)

      node
    end

    private

    def generate_relationships(front_matter)
      front_matter.filter { |k, _| Relationship::TYPES.include?(k.to_sym) }.map do |type, to|
        Relationship.new(type: type, to: to)
      end
    end
  end
end
