# frozen_string_literal: true

require_relative 'base_transformer'

module Jekyll
  module WebAwesome
    # Transforms icon syntax into wa-icon elements
    # Primary syntax: $$$icon-name
    # Alternative syntax: :::wa-icon icon-name
    #
    # Examples:
    # $$$settings -> <wa-icon name="settings"></wa-icon>
    # $$$home -> <wa-icon name="home"></wa-icon>
    # $$$user-circle -> <wa-icon name="user-circle"></wa-icon>
    class IconTransformer < BaseTransformer
      def self.transform(content)
        # Protect code blocks first
        protected_content, code_blocks = protect_code_blocks(content)

        # Apply primary syntax transformation
        # Only block patterns that look like incomplete icon names:
        # $$$icon name (where 'icon name' could be intended as one identifier)
        result = protected_content.gsub(/\$\$\$([a-zA-Z0-9\-_]+)(?![a-zA-Z0-9\-_]|\s+name\b)/) do
          icon_name = ::Regexp.last_match(1)
          build_icon_html(icon_name)
        end

        # Apply alternative syntax transformation
        result = result.gsub(/:::wa-icon\s+([a-zA-Z0-9\-_]+)\s*\n:::/m) do
          icon_name = ::Regexp.last_match(1)
          build_icon_html(icon_name)
        end

        # Restore code blocks
        restore_code_blocks(result, code_blocks)
      end

      class << self
        private

        def build_icon_html(icon_name)
          # Clean and validate icon name
          clean_name = icon_name.strip

          # Return the wa-icon element
          "<wa-icon name=\"#{clean_name}\"></wa-icon>"
        end

        def protect_code_blocks(content)
          code_blocks = {}
          counter = 0

          # Protect fenced code blocks
          protected = content.gsub(/```.*?```/m) do |match|
            placeholder = "ICON_PROTECTED_CODE_BLOCK_#{counter}"
            code_blocks[placeholder] = match
            counter += 1
            placeholder
          end

          # Protect inline code
          protected = protected.gsub(/`[^`]+`/) do |match|
            placeholder = "ICON_PROTECTED_INLINE_CODE_#{counter}"
            code_blocks[placeholder] = match
            counter += 1
            placeholder
          end

          [protected, code_blocks]
        end

        def restore_code_blocks(content, code_blocks)
          result = content
          code_blocks.each do |placeholder, original|
            result = result.gsub(placeholder, original)
          end
          result
        end
      end
    end
  end
end
