require "spec_helper"
require "marmerdo/node"

RSpec.describe Marmerdo::Node do
  subject(:node) { Marmerdo::Node.new(path: path, name: name, relationships: relationships) }

  let(:path) { "spec/fixtures/user.md" }
  let(:name) { "User" }
  let(:relationships) { [] }

  describe "#generate_mermaid_link" do
    subject(:generate_mermaid_link) { node.generate_mermaid_link(output_path) }

    let(:output_path) { "output.md" }

    it "returns a mermaid link" do
      expect(generate_mermaid_link).to eq('link User "./spec/fixtures/user.md"')
    end

    context "when output path in different directory" do
      let(:output_path) { "tmp/output.md" }

      it "returns a mermaid link" do
        expect(generate_mermaid_link).to eq('link User "../spec/fixtures/user.md"')
      end
    end
  end
end
