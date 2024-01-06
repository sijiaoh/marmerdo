require "pathname"

module Marmerdo
  class Node
    # @return [Symbol]
    attr_reader :path
    # @return [Symbol]
    attr_reader :name
    # @return [Symbol, nil]
    attr_reader :namespace
    attr_accessor :relationships

    def initialize(path:, name:, namespace:, relationships:)
      @path = path
      @name = name.to_sym
      @namespace = namespace&.to_sym
      @relationships = relationships
    end

    def to_mermaid_str
      str = "class #{name}"

      return str if namespace.nil?

      [
        "namespace #{namespace} {",
        str,
        "}"
      ].join("\n")
    end

    def generate_mermaid_link(output_path, enable_link_extension:)
      path = enable_link_extension ? @path : Pathname.new(@path).sub_ext("").to_s

      output_dir = Pathname.new(output_path).dirname
      relative_path = Pathname.new(path).relative_path_from(output_dir).to_s
      relative_path = "./#{relative_path}" unless relative_path.start_with?("../")
      "link #{name} \"#{relative_path}\""
    end
  end
end
