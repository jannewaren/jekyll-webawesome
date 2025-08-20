# frozen_string_literal: true

require 'rspec'
require_relative '../lib/jekyll/webawesome/transformers/card_transformer'

RSpec.describe Jekyll::WebAwesome::CardTransformer do
  describe '.transform' do
    context 'basic card' do
      it 'transforms simple card syntax' do
        input = <<~MARKDOWN
          ===
          This is a basic card with just content.
          ===
        MARKDOWN

        result = described_class.transform(input)
        expect(result).to include('<wa-card>')
        expect(result).to include('This is a basic card with just content.')
        expect(result).to include('</wa-card>')
      end
    end

    context 'card with header' do
      it 'transforms card with heading to header slot' do
        input = <<~MARKDOWN
          ===
          # Card Title
          This is the card content.
          ===
        MARKDOWN

        result = described_class.transform(input)
        expect(result).to include('<wa-card with-header>')
        expect(result).to include('<div slot="header">')
        expect(result).to include('Card Title')
        expect(result).to include('This is the card content.')
      end
    end

    context 'card with media' do
      it 'transforms card with image to media slot' do
        input = <<~MARKDOWN
          ===
          ![Alt text](image.jpg)
          # Card Title
          This is the card content.
          ===
        MARKDOWN

        result = described_class.transform(input)
        expect(result).to include('<wa-card with-media with-header>')
        expect(result).to include('<img slot="media" src="image.jpg" alt="Alt text">')
        expect(result).to include('<div slot="header">')
      end
    end

    context 'card with footer' do
      it 'transforms card with trailing link to footer slot' do
        input = <<~MARKDOWN
          ===
          # Card Title
          This is the card content.
          [Learn More](https://example.com)
          ===
        MARKDOWN

        result = described_class.transform(input)
        expect(result).to include('<wa-card with-header with-footer>')
        expect(result).to include('<div slot="footer">')
        expect(result).to include('<wa-button href="https://example.com">Learn More</wa-button>')
      end
    end

    context 'card with appearance' do
      it 'transforms card with filled appearance' do
        input = <<~MARKDOWN
          ===filled
          # Card Title
          This is a filled card.
          ===
        MARKDOWN

        result = described_class.transform(input)
        expect(result).to include('<wa-card appearance="filled" with-header>')
      end

      it 'defaults to outlined appearance when not specified' do
        input = <<~MARKDOWN
          ===
          # Card Title
          This is a default card.
          ===
        MARKDOWN

        result = described_class.transform(input)
        expect(result).to include('<wa-card with-header>')
        expect(result).not_to include('appearance="outlined"')
      end

      it 'transforms card with accent appearance' do
        input = <<~MARKDOWN
          ===accent
          # Accent Card
          This is an accent card.
          ===
        MARKDOWN

        result = described_class.transform(input)
        expect(result).to include('<wa-card appearance="accent" with-header>')
      end
    end

    context 'complete card' do
      it 'transforms card with all components' do
        input = <<~MARKDOWN
          ===filled
          ![Hero image](hero.jpg)
          # Complete Card
          This card has everything: media, header, content, and footer.
          [Get Started](https://example.com)
          ===
        MARKDOWN

        result = described_class.transform(input)
        expect(result).to include('<wa-card appearance="filled" with-media with-header with-footer>')
        expect(result).to include('<img slot="media" src="hero.jpg" alt="Hero image">')
        expect(result).to include('<div slot="header">')
        expect(result).to include('Complete Card')
        expect(result).to include('This card has everything')
        expect(result).to include('<div slot="footer">')
        expect(result).to include('<wa-button href="https://example.com">Get Started</wa-button>')
      end
    end
  end
end
