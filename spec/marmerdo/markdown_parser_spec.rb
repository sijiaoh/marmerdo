require "json"
require "spec_helper"
require "marmerdo/markdown_parser"

RSpec.describe Marmerdo::MarkdownParser do
  describe "#parse" do
    subject(:parse) { Marmerdo::MarkdownParser.new(path, markdown_content).parse }

    let(:path) { "spec/fixtures/author.md" }
    let(:front_matter) do
      {
        marmerdo: {
          name: :Author,
          inheritance: :User
        }
      }
    end
    let(:markdown_content) { combine_into_markdown(front_matter: front_matter) }

    it "returns a node with relationships" do
      node = parse

      expect(node).to be_a(Marmerdo::Node)
      expect(node.path).to eq(path)
      expect(node.name).to eq(front_matter[:marmerdo][:name])
      expect(node.namespace).to eq(nil)

      relationships = node.relationships
      expect(relationships.size).to eq(1)
      expect(relationships.first).to be_a(Marmerdo::Relationship)
    end

    context "when front matter has name" do
      let(:front_matter) { { marmerdo: { name: :Viewer } } }

      it "node name is overwritten by front matter" do
        expect(parse.name).to eq(:Viewer)
      end
    end

    context "when front matter has namespace" do
      let(:front_matter) { { marmerdo: { namespace: :blog } } }

      it "node namespace is overwritten by front matter" do
        expect(parse.namespace).to eq(:blog)
      end
    end

    context "when markdown has no front matter" do
      let(:markdown_content) { "" }

      it("returns nil") { expect(parse).to be_nil }
    end

    context "when markdown has no marmerdo front matter" do
      let(:front_matter) { {} }

      it("returns nil") { expect(parse).to be_nil }
    end
  end
end
