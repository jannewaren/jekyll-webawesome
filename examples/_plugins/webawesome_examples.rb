# frozen_string_literal: true

require 'rouge'

# Generates the multi-page examples site from the shared examples.yaml dataset
# (examples/_data/examples.yaml). For every example it precomputes two HTML
# strings:
#
#   * code_html     — the raw markawesome snippet, Rouge-highlighted only. It
#                     never touches Markawesome::Transformer, so the sigils show
#                     verbatim.
#   * rendered_html — the snippet run through the SAME two passes a real page
#                     gets: Markawesome::Transformer.process (splices in the
#                     component HTML) followed by the site's own Kramdown
#                     converter (the load-bearing second pass — without it,
#                     block <wa-*> components get wrapped in <p> and render
#                     empty).
#
# Pages are emitted as .html (not .md) so the plugin's own pre_render hook —
# which only transforms markdown files — leaves them untouched; otherwise it
# would re-transform the snippet we are trying to display.
module Jekyll
  module WebAwesomeExamples
    class Generator < Jekyll::Generator
      safe false
      priority :low

      def generate(site)
        data = site.data['examples']
        return unless data

        converter = site.find_converter_instance(Jekyll::Converters::Markdown)
        options = build_options(site)
        categories = data['categories'] || []

        nav = categories.map do |category|
          {
            'id' => category['id'],
            'title' => category['title'],
            'url' => "/#{category['id']}/",
            'summary' => summary_of(category['intro'])
          }
        end

        categories.each do |category|
          examples = (category['examples'] || []).map do |ex|
            render_example(ex, converter, options)
          end
          intro_html = render_markdown(converter, category['intro'], options)
          site.pages << CategoryPage.new(site, category, examples, intro_html, nav)
        end

        site.pages << HomePage.new(site, data['title'], nav)
      end

      private

      # Mirror lib/jekyll/webawesome/plugin.rb's image_dialog_config so previews
      # match what a live page would render.
      def build_options(site)
        options = {}
        cfg = site.config.dig('webawesome', 'image_dialog')
        return options unless cfg

        if cfg.is_a?(Hash)
          hash = cfg.transform_keys(&:to_sym)
          hash[:enabled] = true unless hash.key?(:enabled)
          options[:image_dialog] = hash
        else
          options[:image_dialog] = { enabled: true }
        end
        options
      end

      def render_example(ex, converter, options)
        return { 'heading' => ex['heading'] } if ex['heading']

        code = ex['code'].to_s
        {
          'title' => ex['title'],
          'description_html' => render_inline(converter, ex['description'], options),
          'code_html' => highlight(code),
          'rendered_html' => render_markdown(converter, code, options)
        }
      end

      def highlight(code)
        lexer = Rouge::Lexers::Markdown.new
        formatter = Rouge::Formatters::HTML.new
        inner = formatter.format(lexer.lex(code.to_s))
        %(<div class="language-markdown highlighter-rouge"><div class="highlight">) +
          %(<pre class="highlight"><code>#{inner}</code></pre></div></div>)
      end

      # The full two-pass render: markawesome transform, then the site's Kramdown.
      def render_markdown(converter, text, options)
        return nil if text.nil? || text.to_s.strip.empty?

        converter.convert(Markawesome::Transformer.process(text.to_s, options))
      end

      # Like render_markdown but strips the wrapping <p> so short descriptions
      # sit inline.
      def render_inline(converter, text, options)
        html = render_markdown(converter, text, options)
        return nil unless html

        html.strip.sub(%r{\A<p>}, '').sub(%r{</p>\z}, '')
      end

      def summary_of(intro)
        return '' if intro.nil?

        sentence = intro.to_s.strip.split(/(?<=\.)\s/).first.to_s
        sentence.gsub(/[`*]/, '')
      end
    end

    # A generated category page: /<id>/index.html rendered by the category layout.
    class CategoryPage < Jekyll::PageWithoutAFile
      def initialize(site, category, examples, intro_html, nav)
        super(site, site.source, category['id'], 'index.html')
        data['layout'] = 'category'
        data['title'] = category['title']
        data['category_id'] = category['id']
        data['examples'] = examples
        data['intro_html'] = intro_html
        data['nav'] = nav
      end
    end

    # The generated home page at /index.html.
    class HomePage < Jekyll::PageWithoutAFile
      def initialize(site, title, nav)
        super(site, site.source, '', 'index.html')
        data['layout'] = 'home'
        data['title'] = title
        data['nav'] = nav
      end
    end
  end
end
