# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Jekyll::WebAwesome::TagTransformer do
  describe '.transform' do
    context 'with basic tag syntax' do
      it 'transforms simple tag without variant' do
        input = "@@@\nBasic tag\n@@@"
        expected = '<wa-tag>Basic tag</wa-tag>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms tag with brand variant' do
        input = "@@@brand\nVersion 2.0\n@@@"
        expected = '<wa-tag variant="brand">Version 2.0</wa-tag>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms tag with success variant' do
        input = "@@@success\nCompleted\n@@@"
        expected = '<wa-tag variant="success">Completed</wa-tag>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms tag with warning variant' do
        input = "@@@warning\nIn Progress\n@@@"
        expected = '<wa-tag variant="warning">In Progress</wa-tag>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms tag with danger variant' do
        input = "@@@danger\nCritical\n@@@"
        expected = '<wa-tag variant="danger">Critical</wa-tag>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms tag with neutral variant' do
        input = "@@@neutral\nDocumentation\n@@@"
        expected = '<wa-tag variant="neutral">Documentation</wa-tag>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end

    context 'with markdown content' do
      it 'handles markdown formatting within tags' do
        input = "@@@success\n**Bold** text\n@@@"
        expected = '<wa-tag variant="success"><strong>Bold</strong> text</wa-tag>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'handles links within tags' do
        input = "@@@brand\n[Link](https://example.com)\n@@@"
        expected = '<wa-tag variant="brand"><a href="https://example.com">Link</a></wa-tag>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'removes paragraph tags for simple text' do
        input = "@@@neutral\nSimple text\n@@@"
        expected = '<wa-tag variant="neutral">Simple text</wa-tag>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end

    context 'with multiple tags' do
      it 'transforms multiple tags in content' do
        input = <<~MARKDOWN
          @@@success
          Done
          @@@

          Some content here.

          @@@warning
          In Progress
          @@@
        MARKDOWN

        result = described_class.transform(input)
        expect(result).to include('<wa-tag variant="success">Done</wa-tag>')
        expect(result).to include('<wa-tag variant="warning">In Progress</wa-tag>')
        expect(result).to include('Some content here.')
      end
    end

    context 'with invalid syntax' do
      it 'ignores invalid variant names' do
        input = "@@@invalid\nText\n@@@"

        result = described_class.transform(input)
        expect(result).to eq(input) # Should remain unchanged
      end

      it 'does not transform incomplete tag syntax' do
        input = "@@@success\nIncomplete tag"

        result = described_class.transform(input)
        expect(result).to eq(input) # Should remain unchanged
      end

      it 'does not transform inline @ symbols' do
        input = 'Contact us @@@example.com for help'

        result = described_class.transform(input)
        expect(result).to eq(input) # Should remain unchanged
      end
    end

    context 'with whitespace handling' do
      it 'trims whitespace from tag content' do
        input = "@@@brand\n  Version 2.0  \n@@@"
        expected = '<wa-tag variant="brand">Version 2.0</wa-tag>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'handles multiline content' do
        input = "@@@neutral\nLine one\nLine two\n@@@"
        expected = '<wa-tag variant="neutral">Line one
Line two</wa-tag>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end
  end
end
