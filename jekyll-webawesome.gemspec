# frozen_string_literal: true

require_relative 'lib/jekyll/webawesome/version'

Gem::Specification.new do |spec|
  spec.name          = 'jekyll-webawesome'
  spec.version       = Jekyll::WebAwesome::VERSION
  spec.authors       = ['Janne Waren']
  spec.email         = ['janne.waren@iki.fi']

  spec.summary       = 'Jekyll plugin for Web Awesome components'
  spec.description   = 'A Jekyll plugin that transforms custom Markdown syntax into Web Awesome components.'
  spec.homepage      = 'https://github.com/jannewaren/jekyll-webawesome'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.2'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = "#{spec.homepage}/tree/main"
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    Dir.glob('lib/**/*.rb') + %w[
      README.md
      CHANGELOG.md
      LICENSE.txt
      jekyll-webawesome.gemspec
    ]
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'jekyll', '>= 3.7', '< 5.0'
  spec.add_dependency 'markawesome', '~> 0.1'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.0'
end
