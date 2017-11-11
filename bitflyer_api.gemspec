# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bitflyer_api/version"

Gem::Specification.new do |spec|
  spec.name          = "bitflyer_api"
  spec.version       = BitflyerApi::VERSION
  spec.authors       = ["mc-chinju", "cohki0305"]
  spec.email         = ["takeiteasy.enjoyeverything@gmail.com"]

  spec.summary       = %q{Bitflyer api wrapper}
  spec.description   = %q{Bitflyer api wrapper. see https://lightning.bitflyer.jp/docs}
  spec.homepage      = "https://github.com/mc-chinju/bitflyer-api"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 0.51.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "vcr"

  spec.add_runtime_dependency "faraday"
  spec.add_runtime_dependency "faraday_middleware"
end
