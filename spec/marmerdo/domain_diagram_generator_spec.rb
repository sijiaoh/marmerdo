require "json"
require "spec_helper"
require "marmerdo/domain_diagram_generator"

RSpec.describe Marmerdo::DomainDiagramGenerator do
  describe "#generate" do
    subject(:generate) { Marmerdo::DomainDiagramGenerator.new(nodes).generate }

    let(:front_matters) do
      [
        { marmerdo: { name: :User } },
        { marmerdo: { name: :Author, inheritance: :User } }
      ]
    end
    let(:markdown_contents) do
      front_matters.map do |front_matter|
        combine_into_markdown(front_matter: front_matter)
      end
    end

    let(:nodes) { markdown_contents.map { |content| Marmerdo::MarkdownParser.new("", content).parse } }

    it "returns a domain diagram with relationships" do
      domain_diagram = generate

      expect(domain_diagram).to eq(<<~DIAGRAM.chomp)
        classDiagram
        class User
        class Author
        User <|-- Author
      DIAGRAM
    end
  end
end
