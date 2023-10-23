# frozen_string_literal: true

require_relative "lib/css_cleaner/version"

Gem::Specification.new do |spec|
  spec.name = "css_cleaner"
  spec.version = CssCleaner::VERSION
  spec.authors = ["AMQOR Merouane"]
  spec.email = ["marouane.amqor6@gmail.com"]

  spec.summary = "A gem to detect and report unused CSS classes in web files."
  spec.description = "CssCleaner parses ERB, HAML, CoffeeScript, JS, CSS, and SCSS files to detect unused CSS classes, helping to optimize and clean your stylesheets."
  spec.homepage = "https://github.com/merouaneamqor/css_cleaner" # Assuming you'll host it on GitHub.
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org" # Standard RubyGems server

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/merouaneamqor/css_cleaner"
  spec.metadata["changelog_uri"] = "https://github.com/merouaneamqor/css_cleaner/blob/main/CHANGELOG.md" # Replace 'main' if you use a different default branch.

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # As the gem grows, you might want to add dependencies.
  # For instance, if you decide to use Nokogiri for parsing:
  # spec.add_dependency "nokogiri", "~> 1.12"
end
