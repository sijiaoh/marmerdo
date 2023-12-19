require "spec_helper"
require "marmerdo/cli"

RSpec.describe Marmerdo::Cli do
  describe "#generate" do
    subject(:generate) { Marmerdo::Cli.start(arguments) }

    let(:output_path) { "tmp/diagram.mmd" }
    let(:arguments) { ["generate", "spec/fixtures/**/*.md", output_path] }

    it "generates a diagram" do
      generate

      expect(File).to exist(output_path)
      expect(File.read(output_path)).to eq(
        [
          "%% #{Marmerdo::OutputGenerator::WARNING_COMMENT}",
          "",
          "classDiagram",
          "class Author",
          "class user",
          'link Author "../spec/fixtures/author.md"',
          'link user "../spec/fixtures/user.md"',
          "user <|-- Author"
        ].join("\n")
      )
    end
  end
end
