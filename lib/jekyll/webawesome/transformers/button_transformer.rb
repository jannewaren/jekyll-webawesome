# frozen_string_literal: true

require_relative 'base_transformer'

module Jekyll
  module WebAwesome
    # Transforms button syntax into wa-button elements
    # Primary syntax: %%%variant?\ncontent\n%%%
    # Alternative syntax: :::wa-button variant?\ncontent\n:::
    # Variants: brand, success, neutral, warning, danger
    #
    # Link buttons: %%%brand\n[Text](url)\n%%%
    # Regular buttons: %%%brand\nText\n%%%
    class ButtonTransformer < BaseTransformer
      def self.transform(content)
        # Define both regex patterns
        primary_regex = /^%%%(brand|success|neutral|warning|danger)?\n(.*?)\n%%%/m
        alternative_regex = /^:::wa-button\s*(brand|success|neutral|warning|danger)?\n(.*?)\n:::/m

        # Define shared transformation logic
        transform_proc = proc do |variant, button_content|
          button_content = button_content.strip

          build_button_html(button_content, variant)
        end

        # Apply both patterns
        patterns = dual_syntax_patterns(primary_regex, alternative_regex, transform_proc)
        apply_multiple_patterns(content, patterns)
      end

      class << self
        private

        def build_button_html(content, variant)
          variant_attr = variant ? " variant=\"#{variant}\"" : ''

          # Check if content contains a markdown link
          link_match = content.match(/^\[([^\]]+)\]\(([^)]+)\)$/)

          if link_match
            # It's a link button
            link_text = link_match[1]
            link_url = link_match[2]

            # Process any markdown in the link text (bold, italic, etc.)
            button_html = markdown_to_html(link_text).strip
            button_html = button_html.gsub(%r{^<p>(.*)</p>$}m, '\1')

            # Fix whitespace issues like in badges
            button_html = button_html.gsub(%r{(</\w+>)\s+}, '\1&nbsp;')

            "<wa-button#{variant_attr} href=\"#{link_url}\">#{button_html}</wa-button>"
          else
            # It's a regular button
            button_html = markdown_to_html(content).strip
            button_html = button_html.gsub(%r{^<p>(.*)</p>$}m, '\1')

            # Fix whitespace issues like in badges
            button_html = button_html.gsub(%r{(</\w+>)\s+}, '\1&nbsp;')

            "<wa-button#{variant_attr}>#{button_html}</wa-button>"
          end
        end
      end
    end
  end
end
