# frozen_string_literal: true

require 'jekyll'
require 'kramdown'
require_relative 'transformers'

module Jekyll
  module WebAwesome
    # Main transformer that orchestrates all component transformers
    class Transformer
      def self.process(content)
        content = BadgeTransformer.transform(content)
        content = ButtonTransformer.transform(content)
        content = CalloutTransformer.transform(content)
        content = CardTransformer.transform(content)
        content = ComparisonTransformer.transform(content)
        content = CopyButtonTransformer.transform(content)
        content = DetailsTransformer.transform(content)
        content = IconTransformer.transform(content)
        content = TagTransformer.transform(content)
        TabsTransformer.transform(content)
      end
    end
  end
end
