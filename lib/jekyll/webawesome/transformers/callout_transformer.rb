# frozen_string_literal: true

require_relative 'base_transformer'

module Jekyll
  module WebAwesome
    # Transforms callout syntax into wa-callout elements
    # Primary syntax: :::variant\ncontent\n:::
    # Alternative syntax: :::wa-callout variant\ncontent\n:::
    # Variants: info, success, neutral, warning, danger
    class CalloutTransformer < BaseTransformer
      def self.transform(content)
        # Define both regex patterns
        primary_regex = /^:::(info|success|neutral|warning|danger)\n(.*?)\n:::/m
        alternative_regex = /^:::wa-callout\s+(info|success|neutral|warning|danger)\n(.*?)\n:::/m

        # Define shared transformation logic
        transform_proc = proc do |variant, inner_content|
          attrs = callout_attributes(variant)

          element_tag = "wa-callout#{attrs[:additional_params]}"
          html_content = "#{attrs[:inner_prepend]}#{markdown_to_html(inner_content)}"

          "<#{element_tag}>#{html_content}</wa-callout>"
        end

        # Apply both patterns
        patterns = dual_syntax_patterns(primary_regex, alternative_regex, transform_proc)
        apply_multiple_patterns(content, patterns)
      end

      class << self
        private

        def callout_attributes(variant)
          case variant
          when 'info'
            {
              additional_params: ' variant="brand"',
              inner_prepend: '<wa-icon slot="icon" name="circle-info" variant="regular"></wa-icon>'
            }
          when 'success'
            {
              additional_params: ' variant="success"',
              inner_prepend: '<wa-icon slot="icon" name="circle-check" variant="regular"></wa-icon>'
            }
          when 'neutral'
            {
              additional_params: ' variant="neutral"',
              inner_prepend: '<wa-icon slot="icon" name="gear" variant="regular"></wa-icon>'
            }
          when 'warning'
            {
              additional_params: ' variant="warning"',
              inner_prepend: '<wa-icon slot="icon" name="triangle-exclamation" variant="regular"></wa-icon>'
            }
          when 'danger'
            {
              additional_params: ' variant="danger"',
              inner_prepend: '<wa-icon slot="icon" name="circle-exclamation" variant="regular"></wa-icon>'
            }
          else
            {
              additional_params: '',
              inner_prepend: ''
            }
          end
        end
      end
    end
  end
end
