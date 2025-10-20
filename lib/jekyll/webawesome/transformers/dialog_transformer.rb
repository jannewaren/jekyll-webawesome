# frozen_string_literal: true

require 'digest'
require_relative 'base_transformer'

module Jekyll
  module WebAwesome
    # Transforms dialog syntax into wa-dialog elements with trigger buttons
    # Primary syntax: ???params\nbutton text\n>>>\ncontent\n???
    # Alternative syntax: :::wa-dialog params\nbutton text\n>>>\ncontent\n:::
    # Params: light-dismiss and optional width (e.g., 500px, 50vw, 40em)
    # Note: Header with close X button is always enabled for accessibility
    class DialogTransformer < BaseTransformer
      def self.transform(content)
        # Define both regex patterns - capture parameter string, button text, and content
        # Params are on the same line as the opening delimiter
        # Button text is on the next line(s) until >>>
        # Content is everything after >>> until the closing delimiter
        primary_regex = /^\?\?\?([^\n]*)$\n(.*?)\n^>>>$\n(.*?)\n^\?\?\?$/m
        alternative_regex = /^:::wa-dialog([^\n]*)$\n(.*?)\n^>>>$\n(.*?)\n^:::$/m

        # Define shared transformation logic
        transform_proc = proc do |params_string, button_text, dialog_content|
          button_text = button_text.strip
          dialog_content = dialog_content.strip

          # Parse parameters
          light_dismiss, width = parse_parameters(params_string)

          # Extract label from first heading or use button text
          label, content_without_label = extract_label(dialog_content, button_text)

          # Generate unique ID based on content
          dialog_id = generate_dialog_id(button_text, dialog_content)

          # Convert markdown to HTML
          content_html = markdown_to_html(content_without_label)

          # Build the dialog HTML
          build_dialog_html(dialog_id, button_text, label, content_html,
                            light_dismiss, width)
        end

        # Apply both patterns
        patterns = dual_syntax_patterns(primary_regex, alternative_regex, transform_proc)
        apply_multiple_patterns(content, patterns)
      end

      class << self
        private

        # Parse parameters from the params string
        def parse_parameters(params_string)
          return [false, nil] if params_string.nil? || params_string.strip.empty?

          tokens = params_string.strip.split(/\s+/)

          light_dismiss = tokens.include?('light-dismiss')

          # Look for width parameter (last token with CSS units)
          width = nil
          tokens.reverse_each do |token|
            if token.match?(/^\d+(\.\d+)?(px|em|rem|vw|vh|%|ch)$/)
              width = token
              break
            end
          end

          [light_dismiss, width]
        end

        # Extract label from first heading in content
        # Always returns a label - uses heading if available, otherwise default_label
        def extract_label(content, default_label)
          # Check if content starts with a heading
          if content.match(/^#\s+(.+?)$/)
            label = Regexp.last_match(1).strip
            # Remove the heading from content
            content_without_label = content.sub(/^#\s+.+?\n/, '').strip
            [label, content_without_label]
          else
            # Use default label (button text) to ensure header is always shown
            [default_label, content]
          end
        end

        # Generate a unique ID for the dialog using MD5 hash
        def generate_dialog_id(button_text, content)
          hash_input = "#{button_text}#{content}"
          hash = Digest::MD5.hexdigest(hash_input)
          "dialog-#{hash[0..7]}" # Use first 8 characters of hash
        end

        # Build the complete dialog HTML with trigger button
        # Header with X close button is always enabled for accessibility
        def build_dialog_html(dialog_id, button_text, label, content_html,
                              light_dismiss, width)
          # Build dialog attributes
          dialog_attrs = ["id='#{dialog_id}'"]
          # Escape both HTML and attribute characters for label
          # Header is always shown to provide the X close button
          dialog_attrs << "label='#{escape_attribute(escape_html(label))}'"
          dialog_attrs << 'light-dismiss' if light_dismiss

          # Build style attribute for width if specified
          style_attr = width ? " style='--width: #{width}'" : ''

          # Check if button contains an image (for image dialog support)
          is_image_button = button_text.include?('<img')

          # Build the HTML
          html = []

          # Add CSS Parts styling for image buttons to make them invisible
          if is_image_button
            button_id = "#{dialog_id}-btn"
            html << '<style>'
            html << "  ##{button_id}::part(base) {"
            html << '    padding: 0;'
            html << '    margin: 0;'
            html << '    border: none;'
            html << '    background: transparent;'
            html << '    box-shadow: none;'
            html << '    color: inherit;'
            html << '    min-width: 0;'
            html << '    height: auto;'
            html << '  }'
            html << "  ##{button_id}::part(base):hover {"
            html << '    background: transparent;'
            html << '    border-color: transparent;'
            html << '  }'
            html << "  ##{button_id}::part(base):active {"
            html << '    background: transparent;'
            html << '    border-color: transparent;'
            html << '  }'
            html << '</style>'
          end

          # Trigger button
          # Only allow HTML for image tags (for image dialog support), escape everything else for security
          button_content = is_image_button ? button_text : escape_html(button_text)
          button_id_attr = is_image_button ? " id='#{button_id}'" : ''
          button_variant = is_image_button ? " variant='text'" : ''
          html << "<wa-button#{button_id_attr}#{button_variant} data-dialog='open #{dialog_id}'>#{button_content}</wa-button>"

          # Dialog element
          html << "<wa-dialog #{dialog_attrs.join(' ')}#{style_attr}>"
          html << content_html

          # Footer with close button
          html << "<wa-button slot='footer' variant='primary' data-dialog='close'>Close</wa-button>"

          html << '</wa-dialog>'

          html.join("\n")
        end

        # Escape HTML entities in text
        def escape_html(text)
          text.gsub('&', '&amp;')
              .gsub('<', '&lt;')
              .gsub('>', '&gt;')
              .gsub('"', '&quot;')
              .gsub("'", '&#39;')
        end

        # Escape attribute values
        def escape_attribute(text)
          text.gsub("'", '&apos;')
              .gsub('"', '&quot;')
        end
      end
    end
  end
end
