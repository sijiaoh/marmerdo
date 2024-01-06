require "front_matter_parser"
require_relative "node"
require_relative "relationship"

module Marmerdo
  class MarkdownParser
    def initialize(path, content)
      @path = path
      @content = content
    end

    # @return [Node, nil] the parsed node or nil if the file has no marmerdo front matter.
    def parse
      return nil unless marmerdo_file?

      Node.new(
        path: @path,
        name: marmerdo_matter["name"] || File.basename(@path, ".*"),
        namespace: marmerdo_matter["namespace"],
        relationships: relationships
      )
    end

    private

    def marmerdo_file?
      front_matter.key?("marmerdo")
    end

    def front_matter
      @front_matter ||= FrontMatterParser::Parser.new(:md).call(@content).front_matter || {}
    end

    def marmerdo_matter
      @marmerdo_matter ||= front_matter["marmerdo"] || {}
    end

    def relationships
      @relationships ||= marmerdo_matter.filter { |k| Relationship::TYPES.include?(k.to_sym) }.map do |type, to|
        Relationship.new(type: type, to: to)
      end
    end
  end
end
