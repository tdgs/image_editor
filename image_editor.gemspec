# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'image_editor/version'

Gem::Specification.new do |spec|
  spec.name          = "image_editor"
  spec.version       = ImageEditor::VERSION
  spec.authors       = ["Giorgos Avramidis"]
  spec.email         = ["avramidg@gmail.com"]
  spec.description   = %q{Simple Image Editor Text Simulator}
  spec.summary       = %q{Simple CLI program to simulate the operations of an Image Editor}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rb-readline"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.1"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "awesome_print"
end
