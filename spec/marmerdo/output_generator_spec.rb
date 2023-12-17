require "spec_helper"
require "marmerdo/output_generator"

RSpec.describe Marmerdo::OutputGenerator do
  describe "#generate" do
    subject(:generate) { Marmerdo::OutputGenerator.new(output_path, domain_diagram).generate }

    let(:output_path) { "output.md" }
    let(:domain_diagram) { "classDiagram" }

    it "returns a string" do
      expect(generate).to be_a(String)
    end

    context "when output type is markdown" do
      let(:output_path) { "output.md" }

      it "returns a markdown with warning comment" do
        expect(generate).to eq(
          [
            "<!-- #{Marmerdo::OutputGenerator::WARNING_COMMENT} -->",
            "",
            "```mermaid",
            "classDiagram",
            "```"
          ].join("\n")
        )
      end
    end

    context "when output type is mermaid" do
      let(:output_path) { "output.mmd" }

      it "returns a mermaid with warning comment" do
        expect(generate).to eq(
          [
            "%% #{Marmerdo::OutputGenerator::WARNING_COMMENT}",
            "",
            "classDiagram"
          ].join("\n")
        )
      end
    end
  end
end
