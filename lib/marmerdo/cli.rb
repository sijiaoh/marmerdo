require "thor"
require_relative "error"
require_relative "markdown_parser"
require_relative "domain_diagram_generator"
require_relative "output_generator"

module Marmerdo
  class Cli < Thor
    class ArgumentError < Error; end

    desc "generate SOURCE_GLOB OUTPUT_PATH", "Generate a mermaid diagram from markdown files"
    option :link_extension, type: :boolean, default: true, desc: "Whether to write the file extension to the link."
    def generate(source_glob, output_path)
      raise ArgumentError, "You must provide a source glob and an output file" if source_glob.nil? || output_path.nil?

      enable_link_extension = options[:link_extension]

      nodes = Dir[source_glob].map do |source_path|
        content = File.read(source_path)
        node = Marmerdo::MarkdownParser.new(source_path, content).parse

        puts "Loaded #{node.name}." if node

        node
      end.compact

      puts "Writing domain diagram to #{output_path}."

      domain_diagram = Marmerdo::DomainDiagramGenerator.new(
        output_path: output_path,
        nodes: nodes,
        enable_link_extension: enable_link_extension
      ).generate
      output_content = OutputGenerator.new(output_path, domain_diagram).generate
      File.write(output_path, output_content)

      puts "Done!"
    end
  end
end
