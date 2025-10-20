# frozen_string_literal: true

require 'digest'
require_relative 'base_transformer'

module Jekyll
  module WebAwesome
    # Transforms standalone images into clickable images that open in dialogs
    # Images can opt-out by adding "nodialog" to the title attribute
    # Example: ![Alt text](image.png "nodialog")
    class ImageDialogTransformer < BaseTransformer
      def self.transform(content)
        # First, protect inline code blocks and comparison blocks from transformation
        protected_content, code_blocks = protect_inline_code(content)
        protected_content, comparison_blocks = protect_comparisons(protected_content)

        # Match markdown images: ![alt](url) or ![alt](url "title")
        # Capture alt text, URL, and optional title
        # URL can contain spaces and special characters
        image_regex = /!\[([^\]]*)\]\(([^)]+?)(?:\s+"([^"]*)")?\)/

        result = protected_content.gsub(image_regex) do |match|
          alt_text = Regexp.last_match(1)
          image_url = Regexp.last_match(2).strip
          title = Regexp.last_match(3)

          # Skip transformation if title contains "nodialog"
          if title&.include?('nodialog')
            # Return original image without dialog
            match
          else
            # Transform to clickable image with dialog
            transform_to_dialog(alt_text, image_url, title)
          end
        end

        # Restore protected comparison blocks first, then inline code
        result = restore_comparisons(result, comparison_blocks)
        restore_inline_code(result, code_blocks)
      end

      class << self
        private

        # Protect inline code from transformation
        def protect_inline_code(content)
          code_blocks = []
          protected = content.gsub(/`[^`]+`/) do |match|
            placeholder = "INLINE_CODE_#{code_blocks.length}"
            code_blocks << match
            placeholder
          end
          [protected, code_blocks]
        end

        # Restore protected inline code
        def restore_inline_code(content, code_blocks)
          code_blocks.each_with_index do |code, index|
            content = content.gsub("INLINE_CODE_#{index}", code)
          end
          content
        end

        # Protect comparison blocks from image transformation
        def protect_comparisons(content)
          comparison_blocks = []
          # Match comparison blocks: <wa-comparison ...>...</wa-comparison>
          protected = content.gsub(/<wa-comparison[^>]*>.*?<\/wa-comparison>/m) do |match|
            placeholder = "COMPARISON_BLOCK_#{comparison_blocks.length}"
            comparison_blocks << match
            placeholder
          end
          [protected, comparison_blocks]
        end

        # Restore protected comparison blocks
        def restore_comparisons(content, comparison_blocks)
          comparison_blocks.each_with_index do |block, index|
            content = content.gsub("COMPARISON_BLOCK_#{index}", block)
          end
          content
        end

        # Transform image into our custom dialog syntax
        # This will be processed by DialogTransformer to create the actual wa-dialog
        def transform_to_dialog(alt_text, image_url, title)
          # Parse width from title if specified (e.g., "50%", "800px", "60vw")
          width = extract_width_from_title(title)

          # Build dialog parameters
          params = %w[light-dismiss without-header]
          params << width if width
          params_string = params.join(' ')

          # Build the button content - a styled image that acts as the trigger
          # Add title attribute if provided and doesn't contain "nodialog" or width
          title_attr = title && !title.include?('nodialog') && !contains_width?(title) ? " title=\"#{title}\"" : ''
          button_content = "<img src=\"#{image_url}\" alt=\"#{alt_text}\" style=\"cursor: zoom-in; display: block; width: 100%; height: auto;\"#{title_attr} />"

          # Build the dialog content - full-size image
          dialog_content = "<img src=\"#{image_url}\" alt=\"#{alt_text}\" style=\"max-width: 100%; height: auto; display: block; margin: 0 auto;\" />"

          # Use our custom dialog syntax that will be processed by DialogTransformer
          # Format: ???params\nbutton_content\n>>>\ndialog_content\n???
          result = []
          result << "???#{params_string}"
          result << button_content
          result << '>>>'
          result << dialog_content
          result << '???'

          result.join("\n")
        end

        # Extract width parameter from title attribute
        def extract_width_from_title(title)
          return nil unless title

          # Match CSS width units: px, em, rem, vw, vh, %, ch
          match = title.match(/(\d+(?:\.\d+)?(?:px|em|rem|vw|vh|%|ch))/)
          match ? match[1] : nil
        end

        # Check if title contains a width value
        def contains_width?(title)
          return false unless title

          title.match?(/\d+(?:\.\d+)?(?:px|em|rem|vw|vh|%|ch)/)
        end
      end
    end
  end
end
