require_relative "lib/wilday_ui/version"

Gem::Specification.new do |spec|
  spec.name        = "wilday_ui"
  spec.version     = WildayUi::VERSION
  spec.authors     = [ "davidwinalda" ]
  spec.email       = [ "davidwinalda94@gmail.com" ]
  spec.homepage    = "https://github.com/davidwinalda/wildayui"
  spec.summary     = "A minimal UI component library for Rails applications"
  spec.description = "Reusable UI components for Rails applications"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/davidwinalda/wildayui"
  spec.metadata["changelog_uri"] = "https://github.com/davidwinalda/wildayui/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.2.1", "< 9.0"
  spec.required_ruby_version = ">= 3.2"
end
