# frozen_string_literal: true

require_relative 'base_transformer'

module Jekyll
  module WebAwesome
    # Transforms summary/details syntax into wa-details elements
    # Primary syntax: ^^^appearance?\nsummary\n>>>\ndetails\n^^^
    # Alternative syntax: :::wa-details appearance?\nsummary\n>>>\ndetails\n:::
    # Appearances: outlined (default), filled, filled-outlined, plain
    class DetailsTransformer < BaseTransformer
      def self.transform(content)
        # Define both regex patterns
        primary_regex = /^\^\^\^?(outlined|filled|filled-outlined|plain)?\n(.*?)\n^>>>\n(.*?)\n^\^\^\^?/m
        alternative_regex = /^:::wa-details\s*(outlined|filled|filled-outlined|plain)?\n(.*?)\n^>>>\n(.*?)\n:::/m

        # Define shared transformation logic
        transform_proc = proc do |appearance_param, summary_content, details_content|
          summary_content = summary_content.strip
          details_content = details_content.strip

          appearance_class = normalize_appearance(appearance_param)
          summary_html = markdown_to_html(summary_content)
          details_html = markdown_to_html(details_content)

          "<wa-details appearance='#{appearance_class}'>" \
          "<span slot='summary'>#{summary_html}</span>" \
          "#{details_html}</wa-details>"
        end

        # Apply both patterns
        patterns = dual_syntax_patterns(primary_regex, alternative_regex, transform_proc)
        apply_multiple_patterns(content, patterns)
      end

      class << self
        private

        def normalize_appearance(appearance_param)
          case appearance_param
          when 'filled'
            'filled'
          when 'filled-outlined'
            'filled outlined'
          when 'plain'
            'plain'
          else
            'outlined'
          end
        end
      end
    end
  end
end
