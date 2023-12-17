require "spec_helper"
require "marmerdo/cli"

RSpec.describe Marmerdo::Cli do
  describe "#generate" do
    subject(:generate) { Marmerdo::Cli.start(arguments) }

    let(:arguments) { ["generate", "spec/fixtures/**/*.md", "tmp/diagram.mmd"] }

    it "generates a diagram" do
      generate

      expect(File).to exist("tmp/diagram.mmd")
      expect(File.read("tmp/diagram.mmd")).to eq(<<~MERMAID.chomp)
        classDiagram
        class Author
        class user
        user <|-- Author
      MERMAID
    end
  end
end
