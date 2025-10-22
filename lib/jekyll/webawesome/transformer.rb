# frozen_string_literal: true

require 'jekyll'
require 'kramdown'
require_relative 'transformers'

module Jekyll
  module WebAwesome
    # Main transformer that orchestrates all component transformers
    class Transformer
      def self.process(content, site = nil)
        content = BadgeTransformer.transform(content)
        content = ButtonTransformer.transform(content)
        content = CalloutTransformer.transform(content)
        content = CardTransformer.transform(content)
        content = CarouselTransformer.transform(content)
        content = ComparisonTransformer.transform(content)
        content = CopyButtonTransformer.transform(content)
        content = DetailsTransformer.transform(content)

        # Apply image dialog transformer BEFORE dialog transformer so it can generate dialog syntax
        content = ImageDialogTransformer.transform(content, site) if site && Plugin.image_dialog_enabled?(site)

        content = DialogTransformer.transform(content)
        content = IconTransformer.transform(content)
        content = TagTransformer.transform(content)
        TabsTransformer.transform(content)
      end
    end
  end
end
