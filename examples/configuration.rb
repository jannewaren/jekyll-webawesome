# frozen_string_literal: true

# Example usage in a Jekyll site's _plugins directory or in config

# Basic usage - just require the gem and it auto-registers
require 'jekyll-webawesome'

# Optional: Configure debug mode programmatically
Jekyll::WebAwesome.configure do |config|
  config.debug_mode = true

  # Control which file types to transform (default: both true)
  config.transform_pages = true      # Transform pages (like index.md, about.md)
  config.transform_documents = true  # Transform documents (like blog posts in _posts)
  
  # Image dialog can be a boolean or a hash with options
  config.image_dialog = { enabled: true, default_width: '90vh' }
end
