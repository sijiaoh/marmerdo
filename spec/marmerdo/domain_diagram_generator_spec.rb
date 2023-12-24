require "json"
require "spec_helper"
require "marmerdo/domain_diagram_generator"

RSpec.describe Marmerdo::DomainDiagramGenerator do
  describe "#generate" do
    subject(:generate) do
      Marmerdo::DomainDiagramGenerator.new(
        output_path: "tmp/diagram.md",
        nodes: nodes,
        enable_link_extension: enable_link_extension
      ).generate
    end

    let(:nodes) do
      [
        Marmerdo::Node.new(
          path: "spec/fixtures/user.md",
          name: "User",
          relationships: []
        ),
        Marmerdo::Node.new(
          path: "spec/fixtures/author.md",
          name: "Author",
          relationships: [Marmerdo::Relationship.new(type: :inheritance, to: "User")]
        )
      ]
    end
    let(:enable_link_extension) { true }

    it "returns a domain diagram" do
      domain_diagram = generate

      expect(domain_diagram).to eq(<<~DIAGRAM.chomp)
        classDiagram
        class User
        class Author
        link User "../spec/fixtures/user.md"
        link Author "../spec/fixtures/author.md"
        User <|-- Author
      DIAGRAM
    end
  end
end
