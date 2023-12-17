require "thor"
require_relative "error"
require_relative "markdown_parser"
require_relative "domain_diagram_generator"
require_relative "output_generator"

module Marmerdo
  class Cli < Thor
    class ArgumentError < Error; end

    desc "generate SOURCE_GLOB OUTPUT_PATH", "Generate a mermaid diagram from markdown files"
    def generate(source_glob, output_path)
      raise ArgumentError, "You must provide a source glob and an output file" if source_glob.nil? || output_path.nil?

      nodes = Dir[source_glob].map do |source_path|
        name = File.basename(source_path, ".*")
        content = File.read(source_path)
        node = Marmerdo::MarkdownParser.new(name, content).parse

        puts "Loaded #{node.name}." if node

        node
      end.compact

      puts "Writing domain diagram to #{output_path}."

      domain_diagram = Marmerdo::DomainDiagramGenerator.new(nodes).generate
      output_content = OutputGenerator.new(output_path, domain_diagram).generate
      File.write(output_path, output_content)

      puts "Done!"
    end
  end
end
