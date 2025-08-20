# frozen_string_literal: true

# Example usage in a Jekyll site's _plugins directory or in config

# Basic usage - just require the gem and it auto-registers
require 'jekyll-webawesome'

# Optional: Configure debug mode programmatically
Jekyll::WebAwesome.configure do |config|
  config.debug_mode = true
end
