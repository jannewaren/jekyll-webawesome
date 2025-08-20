# frozen_string_literal: true

require_relative 'base_transformer'

module Jekyll
  module WebAwesome
    # Transforms tag syntax into wa-tag elements
    # Primary syntax: @@@variant?\ncontent\n@@@
    # Alternative syntax: :::wa-tag variant?\ncontent\n:::
    # Variants: brand, success, neutral, warning, danger
    class TagTransformer < BaseTransformer
      def self.transform(content)
        # Define both regex patterns
        primary_regex = /^@@@(brand|success|neutral|warning|danger)?\n(.*?)\n@@@/m
        alternative_regex = /^:::wa-tag\s*(brand|success|neutral|warning|danger)?\n(.*?)\n:::/m

        # Define shared transformation logic
        transform_proc = proc do |variant, tag_content|
          tag_content = tag_content.strip

          build_tag_html(tag_content, variant)
        end

        # Apply both patterns
        patterns = dual_syntax_patterns(primary_regex, alternative_regex, transform_proc)
        apply_multiple_patterns(content, patterns)
      end

      class << self
        private

        def build_tag_html(content, variant)
          variant_attr = variant ? " variant=\"#{variant}\"" : ''
          tag_html = markdown_to_html(content).strip

          # Remove paragraph tags if the content is just text
          tag_html = tag_html.gsub(%r{^<p>(.*)</p>$}m, '\1')

          "<wa-tag#{variant_attr}>#{tag_html}</wa-tag>"
        end
      end
    end
  end
end
