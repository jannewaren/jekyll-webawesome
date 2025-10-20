# frozen_string_literal: true

require_relative 'transformer'
require_relative 'code_block_transformer'

module Jekyll
  module WebAwesome
    # Plugin class that registers hooks for pre-render processing
    class Plugin
      # Check if debug mode is enabled from various configuration sources
      def self.debug_enabled?(site)
        return true if Jekyll::WebAwesome.configuration&.debug_mode
        return true if site.config.dig('webawesome', 'debug')
        return true if site.config['webawesome_debug']

        false
      end

      # Check if pages transformation is enabled
      def self.transform_pages_enabled?(site)
        # Check plugin configuration first
        return Jekyll::WebAwesome.configuration.transform_pages if Jekyll::WebAwesome.configuration

        # Check site config
        return site.config.dig('webawesome', 'transform_pages') if site.config.dig('webawesome', 'transform_pages') != nil

        # Default to true
        true
      end

      # Check if documents transformation is enabled
      def self.transform_documents_enabled?(site)
        # Check plugin configuration first
        return Jekyll::WebAwesome.configuration.transform_documents if Jekyll::WebAwesome.configuration

        # Check site config
        return site.config.dig('webawesome', 'transform_documents') if site.config.dig('webawesome', 'transform_documents') != nil

        # Default to true
        true
      end

      # Check if image dialog transformation is enabled
      def self.image_dialog_enabled?(site)
        # Check plugin configuration first
        return Jekyll::WebAwesome.configuration.image_dialog if Jekyll::WebAwesome.configuration

        # Check site config
        return site.config.dig('webawesome', 'image_dialog') if site.config.dig('webawesome', 'image_dialog') != nil

        # Default to false (opt-in feature)
        false
      end

      # Get image dialog configuration with default width support
      def self.image_dialog_config(site)
        config = {}
        
        # First check if it's enabled
        enabled_config = nil
        if Jekyll::WebAwesome.configuration
          enabled_config = Jekyll::WebAwesome.configuration.image_dialog
        elsif site.config.dig('webawesome', 'image_dialog') != nil
          enabled_config = site.config.dig('webawesome', 'image_dialog')
        end

        # If disabled or not set, return empty config
        return config unless enabled_config

        # If it's a boolean true, set enabled
        if enabled_config == true
          config[:enabled] = true
        # If it's a hash, merge it
        elsif enabled_config.is_a?(Hash)
          config = enabled_config.transform_keys(&:to_sym)
          config[:enabled] = true unless config.key?(:enabled)
        end

        config
      end

      # Check if a file is a markdown file
      def self.markdown_file?(filepath)
        filepath.to_s.match?(/\.md$/i)
      end

      # Register hooks for pre-render processing (before markdown conversion)
      Jekyll::Hooks.register :documents, :pre_render do |document|
        next unless markdown_file?(document.relative_path)
        next unless transform_documents_enabled?(document.site)

        puts "Jekyll::WebAwesome Processing document (pre-render): #{document.relative_path}\n" if debug_enabled?(document.site)
        document.content = Transformer.process(document.content, document.site)
      end

      Jekyll::Hooks.register :pages, :pre_render do |page|
        next unless markdown_file?(page.relative_path)
        next unless transform_pages_enabled?(page.site)

        puts "Jekyll::WebAwesome Processing page (pre-render): #{page.relative_path}\n" if debug_enabled?(page.site)
        page.content = Transformer.process(page.content, page.site)
      end
    end
  end
end
