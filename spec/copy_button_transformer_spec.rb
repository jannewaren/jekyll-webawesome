# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Jekyll::WebAwesome::CopyButtonTransformer do
  describe '.transform' do
    context 'with primary syntax' do
      it 'transforms simple copy button' do
        input = "<<<\nCopy this text\n<<<"
        expected = '<wa-copy-button value="Copy this text"></wa-copy-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms copy button with longer content' do
        input = "<<<\nThis is a longer text that should be copied to clipboard\n<<<"
        expected = '<wa-copy-button value="This is a longer text that should be copied to clipboard"></wa-copy-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end

    context 'with alternative syntax' do
      it 'transforms simple copy button' do
        input = ":::wa-copy-button\nCopy this text\n:::"
        expected = '<wa-copy-button value="Copy this text"></wa-copy-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms copy button with longer content' do
        input = ":::wa-copy-button\nAnother text to copy\n:::"
        expected = '<wa-copy-button value="Another text to copy"></wa-copy-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end

    context 'with markdown content' do
      it 'handles bold text in copy button content' do
        input = "<<<\n**Bold text** to copy\n<<<"
        expected = '<wa-copy-button value="**Bold text** to copy"></wa-copy-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'handles italic text in copy button content' do
        input = "<<<\n*Italic text* to copy\n<<<"
        expected = '<wa-copy-button value="*Italic text* to copy"></wa-copy-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'handles code in copy button content' do
        input = "<<<\nCopy this `code snippet`\n<<<"
        expected = '<wa-copy-button value="Copy this `code snippet`"></wa-copy-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end

    context 'with special characters' do
      it 'escapes double quotes in value attribute' do
        input = "<<<\nText with \"quotes\"\n<<<"
        expected = '<wa-copy-button value="Text with &quot;quotes&quot;"></wa-copy-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'handles content with various characters' do
        input = "<<<\nSpecial chars: @#$%^&*()\n<<<"
        expected = '<wa-copy-button value="Special chars: @#$%^&*()"></wa-copy-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end

    context 'with multiline content' do
      it 'handles multiline content correctly' do
        input = "<<<\nLine 1\nLine 2\nLine 3\n<<<"
        result = described_class.transform(input)

        expect(result).to start_with('<wa-copy-button value="Line 1')
        expect(result).to include('Line 2')
        expect(result).to include('Line 3')
        expect(result).to end_with('"></wa-copy-button>')
      end
    end

    context 'with surrounding content' do
      it 'transforms copy button in text context' do
        input = "Here is some text\n\n<<<\nCopy me\n<<<\n\nAnd more text"
        expected = "Here is some text\n\n<wa-copy-button value=\"Copy me\"></wa-copy-button>\n\nAnd more text"

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'transforms multiple copy buttons' do
        input = "<<<\nFirst copy\n<<<\n\n<<<\nSecond copy\n<<<"
        expected = '<wa-copy-button value="First copy"></wa-copy-button>' + "\n\n" + '<wa-copy-button value="Second copy"></wa-copy-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end

    context 'with edge cases' do
      it 'handles empty content' do
        input = "<<<\n\n<<<"
        expected = '<wa-copy-button value=""></wa-copy-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'handles whitespace-only content' do
        input = "<<<\n   \n<<<"
        expected = '<wa-copy-button value=""></wa-copy-button>'

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'does not transform incomplete syntax' do
        input = "<<<\nIncomplete"
        expected = "<<<\nIncomplete"

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end

      it 'does not transform if closing delimiter is missing' do
        input = "<<<\nNo closing delimiter\n"
        expected = "<<<\nNo closing delimiter\n"

        result = described_class.transform(input)
        expect(result).to eq(expected)
      end
    end
  end
end
