require "spec_helper"
require "marmerdo/relationship"

RSpec.describe Marmerdo::Relationship do
  describe "#to_mermaid_str" do
    subject(:to_mermaid_str) { Marmerdo::Relationship.new(str).to_mermaid_str(from) }

    let(:from) { "Author" }
    let(:str) { "--> User" }

    it "returns a mermaid relationship" do
      expect(to_mermaid_str).to eq("Author --> User")
    end
  end
end
