module Marmerdo
  class DomainDiagramGenerator
    def initialize(nodes)
      @nodes = nodes
    end

    # @return [String] mermaid class diagram
    def generate
      classes = @nodes.map(&:to_mermaid_line)

      relationships = @nodes.flat_map do |node|
        node.relationships.map do |relationship|
          relationship.to_mermaid_line(node.name)
        end
      end

      [
        "classDiagram",
        classes,
        relationships
      ].flatten.join("\n")
    end

    private

    def nodes_by_name
      @nodes_by_name ||= @nodes.group_by(&:name)
    end
  end
end
