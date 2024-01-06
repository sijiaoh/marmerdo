module Marmerdo
  class DomainDiagramGenerator
    def initialize(output_path:, nodes:, enable_link_extension:)
      @output_path = output_path
      @nodes = nodes
      @enable_link_extension = enable_link_extension
    end

    # @return [String] mermaid class diagram
    def generate
      classes = @nodes.map(&:to_mermaid_str)
      links = @nodes.map do |node|
        node.generate_mermaid_link(@output_path, enable_link_extension: @enable_link_extension)
      end

      relationships = @nodes.flat_map do |node|
        node.relationships.map do |relationship|
          relationship.to_mermaid_str(node.name)
        end
      end

      [
        "classDiagram",
        classes,
        links,
        relationships
      ].flatten.join("\n")
    end

    private

    def nodes_by_name
      @nodes_by_name ||= @nodes.group_by(&:name)
    end
  end
end
