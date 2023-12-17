require "thor"
require_relative "error"
require_relative "markdown_parser"
require_relative "domain_diagram_generator"

module Marmerdo
  class Cli < Thor
    class ArgumentError < Error; end

    desc "generate SOURCE_GLOB OUTPUT", "Generate a mermaid diagram from markdown files"
    def generate(source_glob, output)
      raise ArgumentError, "You must provide a source glob and an output file" if source_glob.nil? || output.nil?

      nodes = Dir[source_glob].map do |source_path|
        puts "Parsing #{source_path}"
        name = File.basename(source_path, ".*")
        content = File.read(source_path)
        Marmerdo::MarkdownParser.new(name, content).parse
      end.compact

      puts "Writing diagram to #{output}"
      mermaid = Marmerdo::DomainDiagramGenerator.new(nodes).generate
      File.write(output, mermaid)
    end
  end
end
