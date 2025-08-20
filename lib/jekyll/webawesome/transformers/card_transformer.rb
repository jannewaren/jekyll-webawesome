# frozen_string_literal: true

require_relative 'base_transformer'

module Jekyll
  module WebAwesome
    # Transforms card syntax into wa-card elements
    # Primary syntax: ===appearance?\ncontent\n===
    # Alternative syntax: :::wa-card appearance?\ncontent\n:::
    # Appearances: outlined (default), filled, filled-outlined, plain, accent
    class CardTransformer < BaseTransformer
      def self.transform(content)
        # Define both regex patterns
        primary_regex = /^===(outlined|filled|filled-outlined|plain|accent)?\n(.*?)\n===/m
        alternative_regex = /^:::wa-card\s*(outlined|filled|filled-outlined|plain|accent)?\n(.*?)\n:::/m

        # Define shared transformation logic
        transform_proc = proc do |appearance_param, card_content|
          card_content = card_content.strip

          appearance = normalize_appearance(appearance_param)
          card_parts = parse_card_content(card_content)

          build_card_html(card_parts, appearance)
        end

        # Apply both patterns
        patterns = dual_syntax_patterns(primary_regex, alternative_regex, transform_proc)
        apply_multiple_patterns(content, patterns)
      end

      class << self
        private

        def normalize_appearance(appearance_param)
          case appearance_param
          when 'filled', 'filled-outlined', 'plain', 'accent'
            appearance_param
          else
            'outlined' # default
          end
        end

        def parse_card_content(content)
          parts = {
            media: nil,
            header: nil,
            content: content,
            footer: nil
          }

          # Extract first image as media
          if content.match(/^!\[([^\]]*)\]\(([^)]+)\)/)
            parts[:media] = {
              alt: ::Regexp.last_match(1),
              src: ::Regexp.last_match(2)
            }
            # Remove the image from content
            content = content.sub(/^!\[([^\]]*)\]\(([^)]+)\)\n?/, '')
          end

          # Extract first heading as header
          if content.match(/^# (.+)$/)
            parts[:header] = ::Regexp.last_match(1).strip
            # Remove the heading from content
            content = content.sub(/^# .+\n?/, '')
          end

          # Extract trailing buttons/links as footer
          # Look for links or buttons at the end of the content
          if content.match(/\n\[([^\]]+)\]\(([^)]+)\)\s*$/)
            parts[:footer] = {
              text: ::Regexp.last_match(1),
              href: ::Regexp.last_match(2)
            }
            # Remove the footer link from content
            content = content.sub(/\n\[([^\]]+)\]\(([^)]+)\)\s*$/, '')
          end

          # Update the main content after extractions
          parts[:content] = content.strip
          parts
        end

        def build_card_html(parts, appearance)
          attributes = []
          attributes << "appearance=\"#{appearance}\"" if appearance != 'outlined'

          # Add SSR attributes if slots are present
          attributes << 'with-media' if parts[:media]
          attributes << 'with-header' if parts[:header]
          attributes << 'with-footer' if parts[:footer]

          attr_string = attributes.empty? ? '' : " #{attributes.join(' ')}"

          html_parts = []

          # Media slot
          html_parts << "<img slot=\"media\" src=\"#{parts[:media][:src]}\" alt=\"#{parts[:media][:alt]}\">" if parts[:media]

          # Header slot
          if parts[:header]
            header_html = markdown_to_html(parts[:header])
            html_parts << "<div slot=\"header\">#{header_html}</div>"
          end

          # Main content
          if parts[:content] && !parts[:content].empty?
            content_html = markdown_to_html(parts[:content])
            html_parts << content_html
          end

          # Footer slot
          html_parts << "<div slot=\"footer\"><wa-button href=\"#{parts[:footer][:href]}\">#{parts[:footer][:text]}</wa-button></div>" if parts[:footer]

          "<wa-card#{attr_string}>#{html_parts.join}</wa-card>"
        end
      end
    end
  end
end
