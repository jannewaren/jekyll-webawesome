# frozen_string_literal: true

RSpec.describe Jekyll::WebAwesome::CalloutTransformer do
  describe '.transform' do
    it 'transforms info callouts' do
      markdown = ":::info\nThis is info\n:::"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-callout variant="brand">')
      expect(result).to include('<wa-icon slot="icon" name="circle-info" variant="solid"></wa-icon>')
      expect(result).to include('<p>This is info</p>')
      expect(result).to include('</wa-callout>')
    end

    it 'transforms success callouts' do
      markdown = ":::success\nThis is success\n:::"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-callout variant="success">')
      expect(result).to include('<wa-icon slot="icon" name="circle-check" variant="solid"></wa-icon>')
    end

    it 'transforms warning callouts' do
      markdown = ":::warning\nThis is warning\n:::"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-callout variant="warning">')
      expect(result).to include('<wa-icon slot="icon" name="triangle-exclamation" variant="solid"></wa-icon>')
    end

    it 'transforms danger callouts' do
      markdown = ":::danger\nThis is danger\n:::"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-callout variant="danger">')
      expect(result).to include('<wa-icon slot="icon" name="circle-exclamation" variant="solid"></wa-icon>')
    end

    it 'transforms neutral callouts' do
      markdown = ":::neutral\nThis is neutral\n:::"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-callout variant="neutral">')
      expect(result).to include('<wa-icon slot="icon" name="gear" variant="solid"></wa-icon>')
    end

    it 'does not transform invalid callout types' do
      markdown = ":::invalid\nThis is invalid\n:::"
      result = described_class.transform(markdown)

      expect(result).to eq(markdown)
    end

    it 'handles multiline content' do
      markdown = ":::info\nLine 1\nLine 2\n\nLine 4\n:::"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-callout variant="brand">')
      expect(result).to include('<p>Line 1')
      expect(result).to include('Line 2</p>')
      expect(result).to include('<p>Line 4</p>')
    end

    it 'handles two separate paragraphs' do
      markdown = ":::warning\nFirst paragraph\n\nSecond one.\n:::"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-callout variant="warning">')
      expect(result).to include('<p>First paragraph</p>')
      expect(result).to include('<p>Second one.</p>')
      expect(result).to include('</wa-callout>')
    end
  end
end
