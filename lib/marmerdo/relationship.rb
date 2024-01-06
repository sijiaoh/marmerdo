require_relative "error"

module Marmerdo
  class Relationship
    # @return [String]
    attr_accessor :str

    def initialize(str)
      @str = str
    end

    def to_mermaid_str(from)
      "#{from} #{str}"
    end
  end
end
