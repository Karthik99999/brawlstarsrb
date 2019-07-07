lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "brawlstars/version"

Gem::Specification.new do |spec|
  spec.name          = "brawlstars"
  spec.version       = Brawlstars::VERSION
  spec.authors       = ["Karthik99999"]
  spec.email         = ["bandagondak0217@gmail.com"]

  spec.summary       = "BrawlAPI for Ruby"
  spec.description   = "A Ruby implementation for BrawlAPI (https://docs.brawlapi.cf), the unofficial Brawl Stars API."
  spec.homepage      = "https://github.com/Karthik99999/brawlstarsrb"
  spec.license       = "MIT"
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.0.0'
  spec.post_install_message = "Brawlstarsrb is my name, GETting is my game!"
  spec.metadata = {
    "bug_tracker_uri"   => "https://github.com/Karthik99999/brawlstarsrb/issues",
    "changelog_uri"     => "https://github.com/Karthik99999/brawlstarsrb/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://www.rubydoc.info/github/Karthik99999/brawlstarsrb",
    "source_code_uri"   => "https://github.com/Karthik99999/brawlstarsrb"
  }
  
  spec.add_dependency "httparty", "~> 0.17.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
end
