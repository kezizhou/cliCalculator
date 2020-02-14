require_relative 'lib/cliCalculator/version'

Gem::Specification.new do |spec|
  spec.name          = "cliCalculator"
  spec.version       = CliCalculator::VERSION
  spec.authors       = ["Keziah Zhou"]
  spec.email         = ["kezizhou@gmail.com"]

  spec.summary       = "A CLI calculator"
  spec.description   = "A CLI calculator Ruby Gem that utilizes stacks for validation"
  spec.homepage      = "https://github.com/kezizhou/cliCalculator"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = ""

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/kezizhou/cliCalculator/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = ["cliCalculator"]
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", "~> 2.1.4"
  spec.add_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.12.2"
end
