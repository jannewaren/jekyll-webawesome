# frozen_string_literal: true

require_relative 'base_transformer'

module Jekyll
  module WebAwesome
    # Transforms copy button syntax into wa-copy-button elements
    # Primary syntax: <<<\ncontent\n<<<
    # Alternative syntax: :::wa-copy-button\ncontent\n:::
    #
    # Usage:
    # <<<
    # This text will be copied to clipboard
    # <<<
    #
    # :::wa-copy-button
    # Copy this text
    # :::
    class CopyButtonTransformer < BaseTransformer
      def self.transform(content)
        # Define both regex patterns
        primary_regex = /^<<<\n(.*?)\n<<</m
        alternative_regex = /^:::wa-copy-button\n(.*?)\n:::/m

        # Define shared transformation logic
        transform_proc = proc do |copy_content|
          copy_content = copy_content.strip

          build_copy_button_html(copy_content)
        end

        # Apply both patterns
        patterns = dual_syntax_patterns(primary_regex, alternative_regex, transform_proc)
        apply_multiple_patterns(content, patterns)
      end

      class << self
        private

        def build_copy_button_html(content)
          # Escape the content for the value attribute
          escaped_content = content.gsub('"', '&quot;').gsub("'", '&#39;')

          "<wa-copy-button value=\"#{escaped_content}\"></wa-copy-button>"
        end
      end
    end
  end
end
