# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Jekyll::WebAwesome::BadgeTransformer do
  describe '.transform' do
    context 'with basic badge syntax' do
      it 'transforms simple badge without variant' do
        input = "!!!\nNew\n!!!"
        expected = '<wa-badge>New</wa-badge>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms badge with brand variant' do
        input = "!!!brand\n5\n!!!"
        expected = '<wa-badge variant="brand">5</wa-badge>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms badge with success variant' do
        input = "!!!success\nOnline\n!!!"
        expected = '<wa-badge variant="success">Online</wa-badge>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms badge with warning variant' do
        input = "!!!warning\n3 pending\n!!!"
        expected = '<wa-badge variant="warning">3 pending</wa-badge>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms badge with danger variant' do
        input = "!!!danger\nError\n!!!"
        expected = '<wa-badge variant="danger">Error</wa-badge>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms badge with neutral variant' do
        input = "!!!neutral\nDraft\n!!!"
        expected = '<wa-badge variant="neutral">Draft</wa-badge>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end

    context 'with alternative badge syntax' do
      it 'transforms simple badge without variant' do
        input = ":::wa-badge\nNew\n:::"
        expected = '<wa-badge>New</wa-badge>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms badge with brand variant' do
        input = ":::wa-badge brand\n5\n:::"
        expected = '<wa-badge variant="brand">5</wa-badge>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms badge with success variant' do
        input = ":::wa-badge success\nOnline\n:::"
        expected = '<wa-badge variant="success">Online</wa-badge>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms badge with warning variant' do
        input = ":::wa-badge warning\n3 pending\n:::"
        expected = '<wa-badge variant="warning">3 pending</wa-badge>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms badge with danger variant' do
        input = ":::wa-badge danger\nError\n:::"
        expected = '<wa-badge variant="danger">Error</wa-badge>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms badge with neutral variant' do
        input = ":::wa-badge neutral\nDraft\n:::"
        expected = '<wa-badge variant="neutral">Draft</wa-badge>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end

    context 'with markdown content' do
      it 'handles markdown formatting within badges' do
        input = "!!!brand\n**Bold** text\n!!!"
        expected = '<wa-badge variant="brand"><strong>Bold</strong>&nbsp;text</wa-badge>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'handles links within badges' do
        input = "!!!\n[Link](http://example.com)\n!!!"
        expected = '<wa-badge><a href="http://example.com">Link</a></wa-badge>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'removes paragraph tags for simple text' do
        input = "!!!\nSimple text\n!!!"
        expected = '<wa-badge>Simple text</wa-badge>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end

    context 'with multiple badges' do
      it 'transforms multiple badges in content' do
        input = <<~MARKDOWN
          !!!brand
          First
          !!!

          Some content here.

          !!!success
          Second
          !!!
        MARKDOWN

        result = described_class.transform(input)
        expect(result).to include('<wa-badge variant="brand">First</wa-badge>')
        expect(result).to include('<wa-badge variant="success">Second</wa-badge>')
        expect(result).to include('Some content here.')
      end
    end

    context 'with invalid syntax' do
      it 'ignores invalid variant names' do
        input = "!!!invalid\nContent\n!!!"
        expected = "!!!invalid\nContent\n!!!"

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'does not transform incomplete badge syntax' do
        input = "!!!\nContent without closing"
        expected = "!!!\nContent without closing"

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'does not transform inline ! symbols' do
        input = 'This has !!! in the middle of text'
        expected = 'This has !!! in the middle of text'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end

    context 'with whitespace handling' do
      it 'trims whitespace from badge content' do
        input = "!!!\n  Spaced content  \n!!!"
        expected = '<wa-badge>Spaced content</wa-badge>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'handles multiline content' do
        input = "!!!\nLine one\nLine two\n!!!"
        expected = "<wa-badge>Line one\nLine two</wa-badge>"

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end
  end
end
