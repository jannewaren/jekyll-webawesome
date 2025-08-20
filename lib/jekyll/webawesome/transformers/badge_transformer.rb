# frozen_string_literal: true

require_relative 'base_transformer'

module Jekyll
  module WebAwesome
    # Transforms badge syntax into wa-badge elements
    # Primary syntax: !!!variant?\ncontent\n!!!
    # Alternative syntax: :::wa-badge variant?\ncontent\n:::
    # Variants: brand, success, neutral, warning, danger
    class BadgeTransformer < BaseTransformer
      def self.transform(content)
        # Define both regex patterns
        primary_regex = /^!!!(brand|success|neutral|warning|danger)?\n(.*?)\n!!!/m
        alternative_regex = /^:::wa-badge\s*(brand|success|neutral|warning|danger)?\n(.*?)\n:::/m

        # Define shared transformation logic
        transform_proc = proc do |variant, badge_content|
          badge_content = badge_content.strip

          build_badge_html(badge_content, variant)
        end

        # Apply both patterns
        patterns = dual_syntax_patterns(primary_regex, alternative_regex, transform_proc)
        apply_multiple_patterns(content, patterns)
      end

      class << self
        private

        def build_badge_html(content, variant)
          variant_attr = variant ? " variant=\"#{variant}\"" : ''
          badge_html = markdown_to_html(content).strip

          # Remove paragraph tags if the content is just text
          badge_html = badge_html.gsub(%r{^<p>(.*)</p>$}m, '\1')

          # Fix whitespace issues in Web Awesome badges by ensuring proper spacing
          # Replace spaces after closing tags with non-breaking spaces to prevent CSS collapse
          badge_html = badge_html.gsub(%r{(</\w+>)\s+}, '\1&nbsp;')

          "<wa-badge#{variant_attr}>#{badge_html}</wa-badge>"
        end
      end
    end
  end
end
