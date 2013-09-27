# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_doc/version'

Gem::Specification.new do |spec|
  spec.name          = "active_doc"
  spec.version       = ActiveDoc::VERSION
  spec.authors       = ["James T Courtois"]
  spec.email         = ["jcourtois@thoughtworks.com"]
  spec.description   = %q{ActiveDoc is a gem that uses Capybara/RSpec tests as source material to generate user
                          documentation.  The gem generates customer-facing html documentation with steps that correspond to steps within your
                          tests.  If you want, you can also have ActiveDoc take screenshots at points within your steps.  ActiveDoc will place
                          these screenshot images under the step where it was taken.  ActiveDoc can also flag documents whose source RSpec tests are not
                          currently passing to indicate that the documented feature may currently be having problems.}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
