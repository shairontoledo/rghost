# frozen_string_literal: true

require "pry-byebug"
require "tmpdir"
require File.expand_path("../lib/rghost", __dir__)

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/rspec-status.txt"
  config.disable_monkey_patching!
  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed
end

RGhost::Config.config_platform

module RGhost
  RG_TMP_DIR = Dir.mktmpdir(Time.now.to_i.to_s)
  private_constant :RG_TMP_DIR

  def self.using_temp_dir(filepath)
    File.expand_path(File.join(RG_TMP_DIR, filepath))
  end

  def self.asser_path(filename)
    File.expand_path(File.join(File.dirname(__FILE__), "assets", filename))
  end
end
