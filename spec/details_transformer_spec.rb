# frozen_string_literal: true

RSpec.describe Jekyll::WebAwesome::DetailsTransformer do
  describe '.transform' do
    it 'transforms basic summary/details' do
      markdown = "^^^\nSummary here\n>>>\nDetails here\n^^^"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-details appearance=\'outlined\'>')
      expect(result).to include('<span slot=\'summary\'><p>Summary here</p>')
      expect(result).to include('<p>Details here</p>')
      expect(result).to include('</wa-details>')
    end

    it 'transforms filled appearance' do
      markdown = "^^^filled\nSummary here\n>>>\nDetails here\n^^^"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-details appearance=\'filled\'>')
    end

    it 'transforms filled-outlined appearance' do
      markdown = "^^^filled-outlined\nSummary here\n>>>\nDetails here\n^^^"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-details appearance=\'filled outlined\'>')
    end

    it 'transforms plain appearance' do
      markdown = "^^^plain\nSummary here\n>>>\nDetails here\n^^^"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-details appearance=\'plain\'>')
    end

    it 'transforms outlined appearance explicitly' do
      markdown = "^^^outlined\nSummary here\n>>>\nDetails here\n^^^"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-details appearance=\'outlined\'>')
    end

    it 'handles multiline summary and details' do
      markdown = "^^^\nSummary line 1\nSummary line 2\n>>>\nDetails line 1\n\nDetails line 2\n^^^"
      result = described_class.transform(markdown)

      expect(result).to include('<span slot=\'summary\'><p>Summary line 1')
      expect(result).to include('Summary line 2</p>')
      expect(result).to include('<p>Details line 1</p>')
      expect(result).to include('<p>Details line 2</p>')
    end

    it 'does not transform incomplete syntax' do
      markdown = "^^^\nSummary here\nDetails here\n^^^"
      result = described_class.transform(markdown)

      expect(result).to eq(markdown)
    end
  end
end
