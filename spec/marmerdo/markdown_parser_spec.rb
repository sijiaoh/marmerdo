require "json"
require "spec_helper"
require "marmerdo/markdown_parser"

RSpec.describe Marmerdo::MarkdownParser do
  describe "#parse" do
    subject(:parse) { Marmerdo::MarkdownParser.new.parse(name, markdown_content) }

    let(:name) { :Author }
    let(:front_matter) do
      {
        namespace: :Blog,
        inheritance: :User
      }
    end
    let(:markdown_content) { combine_into_markdown(front_matter: front_matter) }

    it "returns a node with relationships" do
      node = parse

      expect(node).to be_a(Marmerdo::Node)
      expect(node.name).to eq(name)
      expect(node.namespace).to eq(front_matter[:namespace])

      relationships = node.relationships
      expect(relationships.size).to eq(1)
      expect(relationships.first).to be_a(Marmerdo::Relationship)
      expect(relationships.first.type).to eq(:inheritance)
      expect(relationships.first.to).to eq(front_matter[:inheritance])
    end

    context "when front matter has name" do
      let(:front_matter) do
        super().merge(name: :Viewer)
      end

      it "node name is overwritten by front matter" do
        node = parse

        expect(node.name).to eq(:Viewer)
      end
    end
  end
end
