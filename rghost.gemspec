# shairon.toledo@gmail.com
# 14 de Dezembro de 2007

require_relative "lib/rghost/version"

Gem::Specification.new do |s|
  s.name = "rghost"
  s.version = RGhost::VERSION::STRING
  s.authors = ["Shairon Toledo"]
  s.email = "shairon.toledo@gmail.com"
  s.homepage = "https://github.com/shairontoledo/rghost"
  s.platform = Gem::Platform::RUBY
  s.licenses = ["MIT"]
  s.summary = "Ruby Ghostscript Engine is a document creation and conversion API, supporting PDF, PS, GIF, TIF, PNG, JPG…"
  s.description = "#{s.summary} It uses the GhostScript framework for format conversion, utilizes EPS templates, and is optimized to work with larger documents."

  s.metadata = {
    "changelog_uri" => "#{s.homepage}/master/CHANGELOG.md",
    "documentation_uri" => "https://rubydoc.info/gems/rghost",
    "source_code_uri" => s.homepage
  }

  s.required_ruby_version = ">= 2.7.0"

  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  s.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ spec/ features/ .git .github Gemfile])
    end
  end
  s.require_paths = ["lib"]
end
