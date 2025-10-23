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

      it 'does not leave orphaned variant text when syntax is incomplete' do
        input = <<~MARKDOWN
          @@@brand
          Text content

          More paragraphs
        MARKDOWN

        result = described_class.transform(input)
        # Should not transform since there's no closing @@@
        expect(result).to eq(input)
        expect(result).not_to include('<wa-tag')
      end

      it 'does not leave orphaned variant with blank line after variant' do
        input = "@@@brand\n\nText\n@@@"
        expected = '<wa-tag variant="brand">Text</wa-tag>'

        result = described_class.transform(input)
        # This should still work - blank lines in content are OK
        expect(result).to eq(expected)
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

      it 'handles CRLF (Windows) line endings' do
        input = "@@@brand\r\nVersion 2.0\r\n@@@"
        expected = '<wa-tag variant="brand">Version 2.0</wa-tag>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'handles multiline content with CRLF line endings' do
        input = "@@@danger\r\nLine one\r\nLine two\r\n@@@"
        expected = '<wa-tag variant="danger">Line one
Line two</wa-tag>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'handles mixed LF and CRLF line endings' do
        input = "@@@success\r\nCompleted\n@@@"
        expected = '<wa-tag variant="success">Completed</wa-tag>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end

    context 'with inline syntax' do
      it 'transforms inline tag without variant' do
        input = 'Some text @@@ Basic tag @@@ more text'
        expected = 'Some text <wa-tag>Basic tag</wa-tag> more text'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms inline tag with brand variant' do
        input = 'Check out @@@ brand Version 2.0 @@@ for details'
        expected = 'Check out <wa-tag variant="brand">Version 2.0</wa-tag> for details'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms inline tag with success variant' do
        input = 'Status: @@@ success Completed @@@'
        expected = 'Status: <wa-tag variant="success">Completed</wa-tag>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms inline tag with warning variant' do
        input = 'Note @@@ warning In Progress @@@ today'
        expected = 'Note <wa-tag variant="warning">In Progress</wa-tag> today'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms inline tag with danger variant' do
        input = 'Alert: @@@ danger Critical @@@ issue'
        expected = 'Alert: <wa-tag variant="danger">Critical</wa-tag> issue'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms inline tag with neutral variant' do
        input = 'See @@@ neutral Documentation @@@ for more'
        expected = 'See <wa-tag variant="neutral">Documentation</wa-tag> for more'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'works in headings' do
        input = '## Feature @@@ brand v2.0 @@@ Released'
        expected = '## Feature <wa-tag variant="brand">v2.0</wa-tag> Released'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'works in multiple headings' do
        input = <<~MARKDOWN
          # Main Title @@@ success New @@@

          Some content here.

          ## Section @@@ warning Beta @@@ Overview
        MARKDOWN

        result = described_class.transform(input)
        expect(result).to include('# Main Title <wa-tag variant="success">New</wa-tag>')
        expect(result).to include('## Section <wa-tag variant="warning">Beta</wa-tag> Overview')
      end

      it 'handles multiple inline tags in same line' do
        input = 'Status @@@ success Done @@@ and @@@ warning Pending @@@ items'
        expected = 'Status <wa-tag variant="success">Done</wa-tag> and <wa-tag variant="warning">Pending</wa-tag> items'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'handles inline tags with markdown content' do
        input = 'Check @@@ brand **Bold** text @@@ here'
        expected = 'Check <wa-tag variant="brand"><strong>Bold</strong> text</wa-tag> here'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'trims extra whitespace in inline tags' do
        input = 'Text @@@  brand   Version   @@@  end'
        expected = 'Text <wa-tag variant="brand">Version</wa-tag>  end'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'does not confuse inline with block syntax' do
        input = <<~MARKDOWN
          Inline @@@ success Tag @@@ here

          @@@warning
          Block tag
          @@@
        MARKDOWN

        result = described_class.transform(input)
        expect(result).to include('Inline <wa-tag variant="success">Tag</wa-tag> here')
        expect(result).to include('<wa-tag variant="warning">Block tag</wa-tag>')
      end
    end
  end
end
