# frozen_string_literal: true

RSpec.describe Jekyll::WebAwesome::ComparisonTransformer do
  describe '.transform' do
    context 'with primary syntax' do
      it 'transforms basic comparison with two images' do
        markdown = <<~MD
          |||
          ![Before image](before.jpg)
          ![After image](after.jpg)
          |||
        MD

        result = described_class.transform(markdown)

        expect(result).to include('<wa-comparison>')
        expect(result).to include('<img slot="before" src="before.jpg" alt="Before image" />')
        expect(result).to include('<img slot="after" src="after.jpg" alt="After image" />')
        expect(result).to include('</wa-comparison>')
      end

      it 'transforms comparison with complex alt text' do
        markdown = <<~MD
          |||
          ![Grayscale version of kittens](grayscale.jpg)
          ![Color version of kittens](color.jpg)
          |||
        MD

        result = described_class.transform(markdown)

        expect(result).to include('<wa-comparison>')
        expect(result).to include('<img slot="before" src="grayscale.jpg" alt="Grayscale version of kittens" />')
        expect(result).to include('<img slot="after" src="color.jpg" alt="Color version of kittens" />')
        expect(result).to include('</wa-comparison>')
      end

      it 'transforms comparison with empty alt text' do
        markdown = <<~MD
          |||
          ![](before.jpg)
          ![](after.jpg)
          |||
        MD

        result = described_class.transform(markdown)

        expect(result).to include('<wa-comparison>')
        expect(result).to include('<img slot="before" src="before.jpg" alt="" />')
        expect(result).to include('<img slot="after" src="after.jpg" alt="" />')
        expect(result).to include('</wa-comparison>')
      end

      it 'handles URLs with query parameters' do
        markdown = <<~MD
          |||
          ![Before](https://example.com/before.jpg?v=1&format=webp)
          ![After](https://example.com/after.jpg?v=2&format=webp)
          |||
        MD

        result = described_class.transform(markdown)

        expect(result).to include('<wa-comparison>')
        expect(result).to include('<img slot="before" src="https://example.com/before.jpg?v=1&format=webp" alt="Before" />')
        expect(result).to include('<img slot="after" src="https://example.com/after.jpg?v=2&format=webp" alt="After" />')
        expect(result).to include('</wa-comparison>')
      end

      it 'does not transform when there is only one image' do
        markdown = <<~MD
          |||
          ![Single image](single.jpg)
          |||
        MD

        result = described_class.transform(markdown)

        # Should return original content unchanged
        expect(result).to eq(markdown)
        expect(result).not_to include('<wa-comparison>')
      end

      it 'does not transform when there are three images' do
        markdown = <<~MD
          |||
          ![First](first.jpg)
          ![Second](second.jpg)
          ![Third](third.jpg)
          |||
        MD

        result = described_class.transform(markdown)

        # Should return original content unchanged
        expect(result).to eq(markdown)
        expect(result).not_to include('<wa-comparison>')
      end

      it 'does not transform when there are no images' do
        markdown = <<~MD
          |||
          Some text without images
          |||
        MD

        result = described_class.transform(markdown)

        # Should return original content unchanged
        expect(result).to eq(markdown)
        expect(result).not_to include('<wa-comparison>')
      end

      it 'handles multiple comparison blocks' do
        markdown = <<~MD
          |||
          ![Before 1](before1.jpg)
          ![After 1](after1.jpg)
          |||

          Some text in between.

          |||
          ![Before 2](before2.jpg)
          ![After 2](after2.jpg)
          |||
        MD

        result = described_class.transform(markdown)

        # Should transform both blocks
        expect(result.scan('<wa-comparison>').length).to eq(2)
        expect(result).to include('<img slot="before" src="before1.jpg" alt="Before 1" />')
        expect(result).to include('<img slot="after" src="after1.jpg" alt="After 1" />')
        expect(result).to include('<img slot="before" src="before2.jpg" alt="Before 2" />')
        expect(result).to include('<img slot="after" src="after2.jpg" alt="After 2" />')
        expect(result).to include('Some text in between.')
      end
    end

    context 'with alternative syntax' do
      it 'transforms basic comparison with two images' do
        markdown = <<~MD
          :::wa-comparison
          ![Before image](before.jpg)
          ![After image](after.jpg)
          :::
        MD

        result = described_class.transform(markdown)

        expect(result).to include('<wa-comparison>')
        expect(result).to include('<img slot="before" src="before.jpg" alt="Before image" />')
        expect(result).to include('<img slot="after" src="after.jpg" alt="After image" />')
        expect(result).to include('</wa-comparison>')
      end

      it 'does not transform when there is only one image' do
        markdown = <<~MD
          :::wa-comparison
          ![Single image](single.jpg)
          :::
        MD

        result = described_class.transform(markdown)

        # Should return original content unchanged
        expect(result).to eq(markdown)
        expect(result).not_to include('<wa-comparison>')
      end

      it 'transforms comparison with position parameter' do
        markdown = <<~MD
          :::wa-comparison 30
          ![Before image](before.jpg)
          ![After image](after.jpg)
          :::
        MD

        result = described_class.transform(markdown)

        expect(result).to include('<wa-comparison position="30">')
        expect(result).to include('<img slot="before" src="before.jpg" alt="Before image" />')
        expect(result).to include('<img slot="after" src="after.jpg" alt="After image" />')
        expect(result).to include('</wa-comparison>')
      end
    end

    context 'with mixed content' do
      it 'ignores text and other content, only processes images' do
        markdown = <<~MD
          |||
          Some introductory text.
          ![Before image](before.jpg)
          More text in the middle.
          ![After image](after.jpg)
          Concluding text.
          |||
        MD

        result = described_class.transform(markdown)

        expect(result).to include('<wa-comparison>')
        expect(result).to include('<img slot="before" src="before.jpg" alt="Before image" />')
        expect(result).to include('<img slot="after" src="after.jpg" alt="After image" />')
        expect(result).to include('</wa-comparison>')
      end
    end

    context 'with special characters in alt text' do
      it 'handles quotes and special characters in alt text' do
        markdown = <<~MD
          |||
          ![Before: "quoted" text & symbols](before.jpg)
          ![After: 'single quotes' & more](after.jpg)
          |||
        MD

        result = described_class.transform(markdown)

        expect(result).to include('<wa-comparison>')
        expect(result).to include('<img slot="before" src="before.jpg" alt="Before: &quot;quoted&quot; text &amp; symbols" />')
        expect(result).to include('<img slot="after" src="after.jpg" alt="After: \'single quotes\' &amp; more" />')
        expect(result).to include('</wa-comparison>')
      end

      it 'transforms comparison with position parameter' do
        markdown = <<~MD
          |||25
          ![Before image](before.jpg)
          ![After image](after.jpg)
          |||
        MD

        result = described_class.transform(markdown)

        expect(result).to include('<wa-comparison position="25">')
        expect(result).to include('<img slot="before" src="before.jpg" alt="Before image" />')
        expect(result).to include('<img slot="after" src="after.jpg" alt="After image" />')
        expect(result).to include('</wa-comparison>')
      end

      it 'transforms comparison with different position values' do
        markdown = <<~MD
          |||75
          ![Before image](before.jpg)
          ![After image](after.jpg)
          |||
        MD

        result = described_class.transform(markdown)

        expect(result).to include('<wa-comparison position="75">')
        expect(result).to include('<img slot="before" src="before.jpg" alt="Before image" />')
        expect(result).to include('<img slot="after" src="after.jpg" alt="After image" />')
        expect(result).to include('</wa-comparison>')
      end

      it 'does not add position attribute when position is not specified' do
        markdown = <<~MD
          |||
          ![Before image](before.jpg)
          ![After image](after.jpg)
          |||
        MD

        result = described_class.transform(markdown)

        expect(result).to include('<wa-comparison>')
        expect(result).not_to include('position=')
        expect(result).to include('<img slot="before" src="before.jpg" alt="Before image" />')
        expect(result).to include('<img slot="after" src="after.jpg" alt="After image" />')
        expect(result).to include('</wa-comparison>')
      end
    end
  end
end
