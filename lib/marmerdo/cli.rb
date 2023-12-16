require "thor"

module Marmerdo
  class Cli < Thor
    desc "generate", "Generate domain diagram from markdown docs."
    def generate
      puts "Hello World!"
    end
  end
end
