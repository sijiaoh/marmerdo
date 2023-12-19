module Marmerdo
  class DomainDiagramGenerator
    def initialize(output_path:, nodes:)
      @output_path = output_path
      @nodes = nodes
    end

    # @return [String] mermaid class diagram
    def generate
      classes = @nodes.map(&:to_mermaid_line)
      links = @nodes.map { |node| node.generate_mermaid_link(@output_path) }

      relationships = @nodes.flat_map do |node|
        node.relationships.map do |relationship|
          relationship.to_mermaid_line(node.name)
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
