# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "switchcreds/version"

Gem::Specification.new do |spec|
  spec.name          = "switchcreds"
  spec.version       = SwitchCreds::VERSION
  spec.authors       = ["Chris Laflamme"]
  spec.email         = ["chrislaflamme1@gmail.com"]

  spec.summary       = %q{Allows switching between Amazon Web Services (AWS) accounts via command line. Mac, Windows, and Linux supported.}
  spec.description   = %q{SwitchCreds is a simple gem that allows you to switch back and forth between different Amazon Web Services (AWS) accounts via the command line.  This is achieved by automatically updating your ~/.aws/credentials file to point your AWS Command Line Interface (CLI) and AWS Software Development Kit (SDK) calls to the appropriate account. Only Mac supported at this time.}
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = Dir["bin/**/*"] + Dir["lib/**/*"]

  spec.executables   = ["switchcreds"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
