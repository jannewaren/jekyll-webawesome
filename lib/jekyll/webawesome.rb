# frozen_string_literal: true

require_relative 'webawesome/version'
require_relative 'webawesome/transformer'
require_relative 'webawesome/code_block_transformer'
require_relative 'webawesome/plugin'

module Jekyll
  # Main module for Jekyll WebAwesome plugin
  module WebAwesome
    class Error < StandardError; end

    # Configuration options
    class << self
      attr_accessor :configuration

      def configure
        self.configuration ||= Configuration.new
        yield(configuration) if block_given?
        configuration
      end
    end

    # Configuration class for future extensibility
    class Configuration
      attr_accessor :debug_mode, :callout_icons, :custom_components, :transform_pages, :transform_documents

      def initialize
        @debug_mode = false
        @callout_icons = default_callout_icons
        @custom_components = {}
        @transform_pages = true
        @transform_documents = true
      end

      private

      def default_callout_icons
        {
          info: 'circle-info',
          success: 'circle-check',
          neutral: 'gear',
          warning: 'triangle-exclamation',
          danger: 'circle-exclamation'
        }
      end
    end
  end
end
