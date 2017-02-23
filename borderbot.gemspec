# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'borderbot/version'

Gem::Specification.new do |spec|
  spec.name          = "borderbot"
  spec.version       = Borderbot::VERSION
  spec.authors       = ["Sergio Burgueño"]
  spec.email         = ["burguer@gmail.com"]

  spec.summary       = %q{Borders wait times for ruby programmers}
  spec.description   = %q{Get latest borders wait time from U.S. Customs and Border Patrol website parsed as a ruby easy to use hash}
  spec.homepage      = "https://github.com/burguer80/borderbot"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "coveralls"
end
