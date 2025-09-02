# frozen_string_literal: true

require_relative 'base_transformer'

module Jekyll
  module WebAwesome
    # Transforms comparison syntax into wa-comparison elements
    # Primary syntax: >>>\n![before](before.jpg)\n![after](after.jpg)\n>>>
    # Alternative syntax: :::wa-comparison\n![before](before.jpg)\n![after](after.jpg)\n:::
    # Expects exactly two image elements inside the wrapper
    class ComparisonTransformer < BaseTransformer
      def self.transform(content)
        # Process primary syntax
        content = content.gsub(/^>>>\n(.*?)\n>>>/m) do |match|
          inner_content = Regexp.last_match(1).strip
          images = extract_images(inner_content)

          if images.length == 2
            build_comparison_html(inner_content)
          else
            match # Return original match if not exactly 2 images
          end
        end

        # Process alternative syntax
        content.gsub(/^:::wa-comparison\n(.*?)\n:::/m) do |match|
          inner_content = Regexp.last_match(1).strip
          images = extract_images(inner_content)

          if images.length == 2
            build_comparison_html(inner_content)
          else
            match # Return original match if not exactly 2 images
          end
        end
      end

      class << self
        private

        def build_comparison_html(content)
          images = extract_images(content)

          before_image = build_image_html(images[0], 'before')
          after_image = build_image_html(images[1], 'after')

          "<wa-comparison>#{before_image}#{after_image}</wa-comparison>"
        end

        def extract_images(content)
          # Extract markdown image syntax: ![alt](url)
          image_regex = /!\[([^\]]*)\]\(([^)]+)\)/
          content.scan(image_regex)
        end

        def build_image_html(image_match, slot)
          alt_text = image_match[0]
          src = image_match[1]

          # Escape HTML characters in alt text
          escaped_alt = alt_text.gsub('&', '&amp;').gsub('"', '&quot;').gsub('<', '&lt;').gsub('>', '&gt;')

          "<img slot=\"#{slot}\" src=\"#{src}\" alt=\"#{escaped_alt}\" />"
        end
      end
    end
  end
end
