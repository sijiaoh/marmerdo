# frozen_string_literal: true

require "marmerdo"
require "fileutils"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  require_relative "support/markdown_support"
  config.include MarkdownSupport

  FileUtils.mkdir_p("tmp")
end
