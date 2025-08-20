# frozen_string_literal: true

require 'English'
require 'jekyll'
require 'kramdown'

module Jekyll
  module WebAwesome
    # Base class for all Web Awesome component transformers
    # Each transformer should implement the transform method
    class BaseTransformer
      def self.transform(content)
        raise NotImplementedError, 'Subclasses must implement the transform method'
      end

      class << self
        protected

        # Helper method to convert markdown content to HTML
        def markdown_to_html(content)
          Kramdown::Document.new(content).to_html
        end

        # Helper method to apply multiple regex patterns with the same transformation logic
        # @param content [String] The content to transform
        # @param patterns [Array<Hash>] Array of pattern hashes with :regex and :block
        # @return [String] The transformed content
        def apply_multiple_patterns(content, patterns)
          patterns.each do |pattern|
            content = content.gsub(pattern[:regex]) do |match|
              pattern[:block].call(match, $LAST_MATCH_INFO)
            end
          end
          content
        end

        # Helper method to create both primary and alternative syntax patterns
        # @param primary_regex [Regexp] The primary syntax regex
        # @param alternative_regex [Regexp] The alternative syntax regex
        # @param transform_proc [Proc] The proc that takes captured groups and returns HTML
        # @return [Array<Hash>] Array of pattern hashes
        def dual_syntax_patterns(primary_regex, alternative_regex, transform_proc)
          [
            {
              regex: primary_regex,
              block: proc do |_match, matchdata|
                # Get all captured groups from the matchdata
                captures = matchdata.captures
                transform_proc.call(*captures)
              end
            },
            {
              regex: alternative_regex,
              block: proc do |_match, matchdata|
                # Get all captured groups from the matchdata
                captures = matchdata.captures
                transform_proc.call(*captures)
              end
            }
          ]
        end
      end
    end
  end
end
