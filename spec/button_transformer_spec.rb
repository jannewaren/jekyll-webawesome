# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Jekyll::WebAwesome::ButtonTransformer do
  describe '.transform' do
    context 'with link button syntax' do
      it 'transforms simple link button without variant' do
        input = "%%%\n[Click here](https://example.com)\n%%%"
        expected = '<wa-button href="https://example.com">Click here</wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms link button with brand variant' do
        input = "%%%brand\n[Download](https://example.com/download)\n%%%"
        expected = '<wa-button variant="brand" href="https://example.com/download">Download</wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms link button with success variant' do
        input = "%%%success\n[Get Started](https://example.com/start)\n%%%"
        expected = '<wa-button variant="success" href="https://example.com/start">Get Started</wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms link button with warning variant' do
        input = "%%%warning\n[Proceed with Caution](https://example.com/warning)\n%%%"
        expected = '<wa-button variant="warning" href="https://example.com/warning">Proceed with Caution</wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms link button with danger variant' do
        input = "%%%danger\n[Delete](https://example.com/delete)\n%%%"
        expected = '<wa-button variant="danger" href="https://example.com/delete">Delete</wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms link button with neutral variant' do
        input = "%%%neutral\n[Continue](https://example.com/continue)\n%%%"
        expected = '<wa-button variant="neutral" href="https://example.com/continue">Continue</wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end

    context 'with alternative link button syntax' do
      it 'transforms simple link button without variant' do
        input = ":::wa-button\n[Click here](https://example.com)\n:::"
        expected = '<wa-button href="https://example.com">Click here</wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms link button with brand variant' do
        input = ":::wa-button brand\n[Download](https://example.com/download)\n:::"
        expected = '<wa-button variant="brand" href="https://example.com/download">Download</wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end

    context 'with regular button syntax' do
      it 'transforms simple button without variant' do
        input = "%%%\nClick me\n%%%"
        expected = '<wa-button>Click me</wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms button with brand variant' do
        input = "%%%brand\nSubmit Form\n%%%"
        expected = '<wa-button variant="brand">Submit Form</wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms button with danger variant' do
        input = "%%%danger\nDelete Account\n%%%"
        expected = '<wa-button variant="danger">Delete Account</wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end

    context 'with alternative regular button syntax' do
      it 'transforms simple button without variant' do
        input = ":::wa-button\nClick me\n:::"
        expected = '<wa-button>Click me</wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms button with brand variant' do
        input = ":::wa-button brand\nSubmit Form\n:::"
        expected = '<wa-button variant="brand">Submit Form</wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end

    context 'with markdown content in links' do
      it 'handles bold text in link buttons' do
        input = "%%%brand\n[**Download** Now](https://example.com)\n%%%"
        expected = '<wa-button variant="brand" href="https://example.com"><strong>Download</strong>&nbsp;Now</wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'handles italic text in link buttons' do
        input = "%%%success\n[*Get* Started](https://example.com)\n%%%"
        expected = '<wa-button variant="success" href="https://example.com"><em>Get</em>&nbsp;Started</wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'handles complex formatting in link buttons' do
        input = "%%%brand\n[**Download** *v2.0*](https://example.com/v2)\n%%%"
        expected = '<wa-button variant="brand" href="https://example.com/v2"><strong>Download</strong>&nbsp;<em>v2.0</em></wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end

    context 'with markdown content in regular buttons' do
      it 'handles bold text in regular buttons' do
        input = "%%%brand\n**Submit** Form\n%%%"
        expected = '<wa-button variant="brand"><strong>Submit</strong>&nbsp;Form</wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'handles italic text in regular buttons' do
        input = "%%%warning\n*Proceed* with Caution\n%%%"
        expected = '<wa-button variant="warning"><em>Proceed</em>&nbsp;with Caution</wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end

    context 'with invalid syntax' do
      it 'ignores invalid variant names' do
        input = "%%%invalid\nContent\n%%%"
        expected = "%%%invalid\nContent\n%%%"

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'does not transform incomplete button syntax' do
        input = "%%%\nContent without closing"
        expected = "%%%\nContent without closing"

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'does not transform inline % symbols' do
        input = 'This has %%% in the middle of text'
        expected = 'This has %%% in the middle of text'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end

    context 'with whitespace handling' do
      it 'trims whitespace from button content' do
        input = "%%%\n  Spaced content  \n%%%"
        expected = '<wa-button>Spaced content</wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'handles multiline regular button content' do
        input = "%%%\nLine one\nLine two\n%%%"
        expected = "<wa-button>Line one\nLine two</wa-button>"

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end

    context 'edge cases' do
      it 'does not confuse partial link syntax' do
        input = "%%%\n[Incomplete link\n%%%"
        expected = '<wa-button>[Incomplete link</wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'handles links with complex URLs' do
        input = "%%%brand\n[Query Link](https://example.com/path?param=value&other=123)\n%%%"
        expected = '<wa-button variant="brand" href="https://example.com/path?param=value&other=123">Query Link</wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'handles relative URLs' do
        input = "%%%\n[Local Link](/path/to/page)\n%%%"
        expected = '<wa-button href="/path/to/page">Local Link</wa-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end
  end
end
