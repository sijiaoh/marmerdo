require "spec_helper"
require "marmerdo/relationship"

RSpec.describe Marmerdo::Relationship do
  describe "#to_mermaid_str" do
    subject(:to_mermaid_str) { Marmerdo::Relationship.new(type: type, to: to).to_mermaid_str(from) }

    let(:type) { :inheritance }
    let(:to) { "User" }
    let(:from) { "Author" }

    it "returns a mermaid string" do
      expect(to_mermaid_str).to eq("#{to} <|-- #{from}")
    end

    context "when to is array" do
      let(:to) { %w[User Viewer] }

      it "returns a mermaid string" do
        expect(to_mermaid_str).to eq(to.map { |t| "#{t} <|-- #{from}" }.join("\n"))
      end
    end
  end
end
