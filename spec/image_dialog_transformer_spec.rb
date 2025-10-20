# frozen_string_literal: true

require 'spec_helper'
require 'jekyll/webawesome/transformers/image_dialog_transformer'

RSpec.describe Jekyll::WebAwesome::ImageDialogTransformer do
  describe '.transform' do
    context 'with basic image syntax' do
      it 'transforms image to dialog syntax' do
        input = '![Architecture diagram](diagram.png)'

        result = described_class.transform(input)

        # Check it outputs our dialog syntax
        expect(result).to start_with('???light-dismiss without-header')
        expect(result).to include('>>>')
        expect(result).to end_with('???')
        # Check button image (thumbnail)
        expect(result).to include('<img src="diagram.png" alt="Architecture diagram"')
        expect(result).to include('cursor: zoom-in')
      end

      it 'transforms image with empty alt text' do
        input = '![](screenshot.png)'

        result = described_class.transform(input)

        expect(result).to include('<img src="screenshot.png" alt=""')
        expect(result).to start_with('???light-dismiss without-header')
      end

      it 'transforms image with complex alt text' do
        input = '![System Architecture Diagram with Multiple Components](complex-diagram.png)'

        result = described_class.transform(input)

        expect(result).to include('alt="System Architecture Diagram with Multiple Components"')
      end

      it 'handles image URLs with paths' do
        input = '![Diagram](assets/images/diagram.png)'

        result = described_class.transform(input)

        expect(result).to include('assets/images/diagram.png')
      end

      it 'handles image URLs with query parameters' do
        input = '![Image](image.jpg?size=large&quality=high)'

        result = described_class.transform(input)

        expect(result).to include('image.jpg?size=large&quality=high')
      end
    end

    context 'with title attribute' do
      it 'preserves title attribute on image' do
        input = '![Image](image.png "Click to enlarge")'

        result = described_class.transform(input)

        expect(result).to include('title="Click to enlarge"')
      end

      it 'extracts width from title' do
        input = '![Image](image.png "50%")'

        result = described_class.transform(input)

        expect(result).to start_with('???light-dismiss without-header 50%')
        expect(result).not_to include('title="50%"')
      end

      it 'supports px width' do
        input = '![Image](image.png "800px")'

        result = described_class.transform(input)

        expect(result).to start_with('???light-dismiss without-header 800px')
      end

      it 'supports vw width' do
        input = '![Image](image.png "60vw")'

        result = described_class.transform(input)

        expect(result).to start_with('???light-dismiss without-header 60vw')
      end

      it 'supports em width' do
        input = '![Image](image.png "40em")'

        result = described_class.transform(input)

        expect(result).to start_with('???light-dismiss without-header 40em')
      end
    end

    context 'with nodialog opt-out' do
      it 'skips transformation when title contains "nodialog"' do
        input = '![Icon](icon.png "nodialog")'

        result = described_class.transform(input)

        expect(result).to eq(input)
        expect(result).not_to include('???')
      end

      it 'skips transformation with "nodialog" in mixed title' do
        input = '![Icon](icon.png "small icon nodialog")'

        result = described_class.transform(input)

        expect(result).to eq(input)
        expect(result).not_to include('???')
      end
    end

    context 'with multiple images' do
      it 'transforms multiple images independently' do
        input = <<~MARKDOWN
          ![First image](image1.png)

          Some text here.

          ![Second image](image2.jpg)
        MARKDOWN

        result = described_class.transform(input)

        expect(result.scan(/\?\?\?/).length).to eq(4) # 2 opening + 2 closing
        expect(result).to include('image1.png')
        expect(result).to include('image2.jpg')
        expect(result).to include('Some text here.')
      end

      it 'transforms some images and skips others with nodialog' do
        input = <<~MARKDOWN
          ![First](image1.png)
          ![Skip this](image2.png "nodialog")
          ![Third](image3.png)
        MARKDOWN

        result = described_class.transform(input)

        expect(result.scan(/\?\?\?/).length).to eq(4) # 2 images * 2 markers
        expect(result).to include('![Skip this](image2.png "nodialog")') # Original unchanged
      end
    end

    context 'within other markdown content' do
      it 'transforms images within paragraphs' do
        input = 'Check out this image: ![Diagram](diagram.png) in the text.'

        result = described_class.transform(input)

        expect(result).to include('Check out this image:')
        expect(result).to include('???light-dismiss without-header')
        expect(result).to include('in the text.')
      end

      it 'does not affect inline code with similar syntax' do
        input = 'Use syntax like `![alt](url)` to add images.'

        result = described_class.transform(input)

        expect(result).to eq(input)
        expect(result).not_to include('???')
      end

      it 'transforms images in lists' do
        input = <<~MARKDOWN
          - Item 1
          - ![Image](image.png)
          - Item 3
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('???light-dismiss without-header')
        expect(result).to include('- Item 1')
        expect(result).to include('- Item 3')
      end
    end

    context 'edge cases' do
      it 'handles empty content' do
        input = ''

        result = described_class.transform(input)

        expect(result).to eq('')
      end

      it 'handles content with no images' do
        input = 'Just some plain text with no images.'

        result = described_class.transform(input)

        expect(result).to eq(input)
      end

      it 'handles relative URLs' do
        input = '![Image](../images/photo.jpg)'

        result = described_class.transform(input)

        expect(result).to include('../images/photo.jpg')
      end

      it 'handles absolute URLs' do
        input = '![Image](https://example.com/image.png)'

        result = described_class.transform(input)

        expect(result).to include('https://example.com/image.png')
      end
    end

    context 'with comparison blocks' do
      it 'does not transform images inside comparison blocks' do
        input = <<~HTML
          <wa-comparison position="50">
            <img slot="before" src="before.jpg" alt="Before" />
            <img slot="after" src="after.jpg" alt="After" />
          </wa-comparison>
        HTML

        result = described_class.transform(input)

        # Comparison block should remain unchanged
        expect(result).to include('<wa-comparison position="50">')
        expect(result).to include('slot="before"')
        expect(result).to include('slot="after"')
        expect(result).to include('before.jpg')
        expect(result).to include('after.jpg')
        # Should not add dialog syntax
        expect(result).not_to include('???')
      end

      it 'transforms standalone images but not comparison images' do
        input = <<~MARKDOWN
          ![Standalone image](standalone.png)

          <wa-comparison position="25">
            <img slot="before" src="before.jpg" alt="Before" />
            <img slot="after" src="after.jpg" alt="After" />
          </wa-comparison>

          ![Another standalone](another.png)
        MARKDOWN

        result = described_class.transform(input)

        # Standalone images should be transformed
        expect(result.scan(/\?\?\?/).length).to eq(4) # 2 images * 2 markers
        expect(result).to include('standalone.png')
        expect(result).to include('another.png')

        # Comparison should remain unchanged
        expect(result).to include('<wa-comparison position="25">')
        expect(result).to include('slot="before"')
        expect(result).to include('before.jpg')
        expect(result).to include('after.jpg')
      end

      it 'handles multiple comparison blocks' do
        input = <<~HTML
          <wa-comparison>
            <img slot="before" src="img1.jpg" alt="Image 1" />
            <img slot="after" src="img2.jpg" alt="Image 2" />
          </wa-comparison>

          <wa-comparison position="75">
            <img slot="before" src="img3.jpg" alt="Image 3" />
            <img slot="after" src="img4.jpg" alt="Image 4" />
          </wa-comparison>
        HTML

        result = described_class.transform(input)

        # Both comparison blocks should remain unchanged
        expect(result).to include('img1.jpg')
        expect(result).to include('img2.jpg')
        expect(result).to include('img3.jpg')
        expect(result).to include('img4.jpg')
        expect(result.scan(/<wa-comparison/).length).to eq(2)
        # No dialog syntax should be added
        expect(result).not_to include('???')
      end
    end

    context 'dialog syntax output' do
      it 'includes light-dismiss parameter' do
        input = '![Image](image.png)'

        result = described_class.transform(input)

        expect(result).to include('light-dismiss')
      end

      it 'includes without-header parameter' do
        input = '![Image](image.png)'

        result = described_class.transform(input)

        expect(result).to include('without-header')
      end

      it 'uses >>> separator' do
        input = '![Image](image.png)'

        result = described_class.transform(input)

        lines = result.split("\n")
        expect(lines).to include('>>>')
      end

      it 'creates button image with cursor style' do
        input = '![Test](test.png)'

        result = described_class.transform(input)

        expect(result).to include('cursor: zoom-in')
        expect(result).to include('display: block')
        expect(result).to include('width: 100%')
      end

      it 'creates dialog image with max-width style' do
        input = '![Test](test.png)'

        result = described_class.transform(input)

        expect(result).to include('max-width: 100%')
        expect(result).to include('margin: 0 auto')
      end
    end
  end
end
