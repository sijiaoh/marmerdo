require "pathname"

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

    def generate_mermaid_link(output_path)
      output_dir = Pathname.new(output_path).dirname
      relative_path = Pathname.new(path).relative_path_from(output_dir).to_s
      "link #{name} \"#{relative_path}\""
    end
  end
end
