# frozen_string_literal: true

# rubocop:disable Layout/ExtraSpacing

require_relative "lib/go_cqhttp/version"

Gem::Specification.new do |spec|
  spec.name          = "go_cqhttp"
  spec.version       = GoCQHTTP::VERSION
  spec.authors       = ["Dounx"]
  spec.email         = ["imdounx@gmail.com"]

  spec.summary       = "A client wrapper for go-cqhttp"
  spec.description   = "A client wrapper for go-cqhttp"
  spec.homepage      = "https://github.com/dounx/go_cqhttp"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.3.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["bug_tracker_uri"] = "https://github.com/dounx/go_cqhttp/issues"
  spec.metadata["changelog_uri"] = "https://github.com/Dounx/go_cqhttp/blob/main/CHANGELOG.md"
  spec.metadata["documentation_uri"] = "https://github.com/Dounx/go_cqhttp/blob/main/README.md"
  spec.metadata["source_code_uri"] = "https://github.com/dounx/go_cqhttp"


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
