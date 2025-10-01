# frozen_string_literal: true

RSpec.describe Jekyll::WebAwesome::DetailsTransformer do
  describe '.transform' do
    it 'transforms basic summary/details' do
      markdown = "^^^\nSummary here\n>>>\nDetails here\n^^^"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-details appearance=\'outlined\' icon-placement=\'end\'>')
      expect(result).to include('<span slot=\'summary\'><p>Summary here</p>')
      expect(result).to include('<p>Details here</p>')
      expect(result).to include('</wa-details>')
    end

    it 'transforms filled appearance' do
      markdown = "^^^filled\nSummary here\n>>>\nDetails here\n^^^"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-details appearance=\'filled\' icon-placement=\'end\'>')
    end

    it 'transforms filled-outlined appearance' do
      markdown = "^^^filled-outlined\nSummary here\n>>>\nDetails here\n^^^"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-details appearance=\'filled outlined\' icon-placement=\'end\'>')
    end

    it 'transforms plain appearance' do
      markdown = "^^^plain\nSummary here\n>>>\nDetails here\n^^^"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-details appearance=\'plain\' icon-placement=\'end\'>')
    end

    it 'transforms outlined appearance explicitly' do
      markdown = "^^^outlined\nSummary here\n>>>\nDetails here\n^^^"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-details appearance=\'outlined\' icon-placement=\'end\'>')
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

    it 'transforms with icon placement start' do
      markdown = "^^^ start\nSummary here\n>>>\nDetails here\n^^^"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-details appearance=\'outlined\' icon-placement=\'start\'>')
      expect(result).to include('<span slot=\'summary\'><p>Summary here</p>')
      expect(result).to include('<p>Details here</p>')
      expect(result).to include('</wa-details>')
    end

    it 'transforms with icon placement end' do
      markdown = "^^^ end\nSummary here\n>>>\nDetails here\n^^^"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-details appearance=\'outlined\' icon-placement=\'end\'>')
    end

    it 'defaults to end icon placement when not specified' do
      markdown = "^^^\nSummary here\n>>>\nDetails here\n^^^"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-details appearance=\'outlined\' icon-placement=\'end\'>')
    end

    it 'transforms with both appearance and icon placement' do
      markdown = "^^^filled start\nSummary here\n>>>\nDetails here\n^^^"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-details appearance=\'filled\' icon-placement=\'start\'>')
    end

    it 'transforms with appearance first then icon placement' do
      markdown = "^^^outlined end\nSummary here\n>>>\nDetails here\n^^^"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-details appearance=\'outlined\' icon-placement=\'end\'>')
    end

    it 'transforms filled-outlined with start placement' do
      markdown = "^^^filled-outlined start\nSummary here\n>>>\nDetails here\n^^^"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-details appearance=\'filled outlined\' icon-placement=\'start\'>')
    end

    it 'transforms alternative syntax with icon placement' do
      markdown = ":::wa-details filled start\nSummary here\n>>>\nDetails here\n:::"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-details appearance=\'filled\' icon-placement=\'start\'>')
    end

    it 'transforms alternative syntax with only icon placement' do
      markdown = ":::wa-details start\nSummary here\n>>>\nDetails here\n:::"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-details appearance=\'outlined\' icon-placement=\'start\'>')
    end

    it 'handles parameter order flexibility' do
      markdown_1 = "^^^start filled\nSummary here\n>>>\nDetails here\n^^^"
      markdown_2 = "^^^filled start\nSummary here\n>>>\nDetails here\n^^^"

      result_1 = described_class.transform(markdown_1)
      result_2 = described_class.transform(markdown_2)

      # Both should produce the same result regardless of parameter order
      expect(result_1).to include('<wa-details appearance=\'filled\' icon-placement=\'start\'>')
      expect(result_2).to include('<wa-details appearance=\'filled\' icon-placement=\'start\'>')
      expect(result_1).to eq(result_2)
    end
  end
end
