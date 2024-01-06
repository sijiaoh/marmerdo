require "spec_helper"
require "marmerdo/node"

RSpec.describe Marmerdo::Node do
  subject(:node) { Marmerdo::Node.new(path: path, name: name, namespace: namespace, relationships: relationships) }

  let(:path) { "spec/fixtures/user.md" }
  let(:name) { "User" }
  let(:namespace) { nil }
  let(:relationships) { [] }

  describe "#to_mermaid_str" do
    subject(:to_mermaid_str) { node.to_mermaid_str }

    let(:namespace) { nil }

    it "returns a mermaid class" do
      expect(to_mermaid_str).to eq("class User")
    end

    context "when namespace is present" do
      let(:namespace) { "blog" }

      it "returns a mermaid class with namespace" do
        expect(to_mermaid_str).to eq("namespace blog {\nclass User\n}")
      end
    end
  end

  describe "#generate_mermaid_link" do
    subject(:generate_mermaid_link) do
      node.generate_mermaid_link(output_path, enable_link_extension: enable_link_extension)
    end

    let(:output_path) { "output.md" }
    let(:enable_link_extension) { true }

    it "returns a mermaid link" do
      expect(generate_mermaid_link).to eq('link User "./spec/fixtures/user.md"')
    end

    context "when output path in different directory" do
      let(:output_path) { "tmp/output.md" }

      it "returns a mermaid link" do
        expect(generate_mermaid_link).to eq('link User "../spec/fixtures/user.md"')
      end
    end

    context "when enable_link_extension is false" do
      let(:enable_link_extension) { false }

      it "returns a mermaid link" do
        expect(generate_mermaid_link).to eq('link User "./spec/fixtures/user"')
      end
    end
  end
end
