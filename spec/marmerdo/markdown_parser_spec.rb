require "spec_helper"
require "marmerdo/markdown_parser"

RSpec.describe Marmerdo::MarkdownParser do
  describe "#parse" do
    subject(:parse) { described_class.new.parse(name, markdown_content) }

    let(:name) { :Author }
    let(:markdown_content) do
      <<~MARKDOWN
        ---
        namespace: Blog
        inheritance: User
        ---
      MARKDOWN
    end

    it "returns a node with relationships" do
      node = parse

      expect(node).to be_a(Marmerdo::Node)
      expect(node.name).to eq(name)
      expect(node.namespace).to eq(:Blog)

      relationships = node.relationships
      expect(relationships.size).to eq(1)
      expect(relationships.first).to be_a(Marmerdo::Relationship)
      expect(relationships.first.type).to eq(:inheritance)
      expect(relationships.first.to).to eq(:User)
    end
  end
end
