# frozen_string_literal: true

require_relative 'base_transformer'

module Jekyll
  module WebAwesome
    # Transforms tabs syntax into wa-tab-group elements
    # Primary syntax: ++++++placement?\n+++tab1\ncontent\n+++\n+++tab2\ncontent\n+++\n++++++
    # Alternative syntax: :::wa-tabs placement?\n+++tab1\ncontent\n+++\n+++tab2\ncontent\n+++\n:::
    # Placements: top (default), bottom, start, end
    class TabsTransformer < BaseTransformer
      def self.transform(content)
        # Define both regex patterns
        primary_regex = /^\+{6}(top|bottom|start|end)?\n((\+\+\+ [^\n]+\n.*?\n\+\+\+\n?)+)\+{6}/m
        alternative_regex = /^:::wa-tabs\s*(top|bottom|start|end)?\n((\+\+\+ [^\n]+\n.*?\n\+\+\+\n?)+):::/m

        # Define shared transformation logic
        transform_proc = proc do |placement, tabs_block, _third_capture|
          placement ||= 'top'

          tabs, tab_panels = extract_tabs_and_panels(tabs_block)

          "<wa-tab-group placement=\"#{placement}\">#{tabs.join}#{tab_panels.join}</wa-tab-group>"
        end

        # Apply both patterns
        patterns = dual_syntax_patterns(primary_regex, alternative_regex, transform_proc)
        apply_multiple_patterns(content, patterns)
      end

      class << self
        private

        def extract_tabs_and_panels(tabs_block)
          # Extract individual tabs
          tab_contents = tabs_block.scan(/^\+\+\+ ([^\n]+)\n(.*?)\n\+\+\+/m)
          tabs = []
          tab_panels = []

          tab_contents.each_with_index do |(title, panel_content), index|
            tab_id = "tab-#{index + 1}"
            tabs << "<wa-tab panel=\"#{tab_id}\">#{title.strip}</wa-tab>"

            panel_html = markdown_to_html(panel_content.strip)
            tab_panels << "<wa-tab-panel name=\"#{tab_id}\">#{panel_html}</wa-tab-panel>"
          end

          [tabs, tab_panels]
        end
      end
    end
  end
end
