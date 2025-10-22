# frozen_string_literal: true

require 'spec_helper'
require 'jekyll/webawesome/transformers/carousel_transformer'

RSpec.describe Jekyll::WebAwesome::CarouselTransformer do
  describe '.transform' do
    context 'with primary syntax' do
      it 'transforms basic carousel with no parameters' do
        input = <<~MARKDOWN
          ~~~~~~
          ~~~
          First slide content
          ~~~
          ~~~
          Second slide content
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('<wa-carousel>')
        expect(result).to include('<wa-carousel-item>')
        expect(result).to include('First slide content')
        expect(result).to include('Second slide content')
        expect(result).to include('</wa-carousel-item>')
        expect(result).to include('</wa-carousel>')
      end

      it 'transforms carousel with markdown content in slides' do
        input = <<~MARKDOWN
          ~~~~~~
          ~~~
          # Heading
          **Bold text** and *italic text*
          ~~~
          ~~~
          - List item 1
          - List item 2
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('<h1')
        expect(result).to include('Heading')
        expect(result).to include('<strong>Bold text</strong>')
        expect(result).to include('<em>italic text</em>')
        expect(result).to include('<li>List item 1</li>')
      end

      it 'transforms carousel with images' do
        input = <<~MARKDOWN
          ~~~~~~
          ~~~
          ![Mountain](mountain.jpg)
          ~~~
          ~~~
          ![Ocean](ocean.jpg)
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('<img src="mountain.jpg" alt="Mountain"')
        expect(result).to include('<img src="ocean.jpg" alt="Ocean"')
      end

      it 'transforms carousel with slides-per-page parameter' do
        input = <<~MARKDOWN
          ~~~~~~3
          ~~~
          Slide 1
          ~~~
          ~~~
          Slide 2
          ~~~
          ~~~
          Slide 3
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('slides-per-page="3"')
        expect(result).to include('Slide 1')
        expect(result).to include('Slide 2')
        expect(result).to include('Slide 3')
      end

      it 'transforms carousel with slides-per-page and slides-per-move parameters' do
        input = <<~MARKDOWN
          ~~~~~~3 2
          ~~~
          Slide 1
          ~~~
          ~~~
          Slide 2
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('slides-per-page="3"')
        expect(result).to include('slides-per-move="2"')
      end

      it 'transforms carousel with loop parameter' do
        input = <<~MARKDOWN
          ~~~~~~loop
          ~~~
          Slide 1
          ~~~
          ~~~
          Slide 2
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('<wa-carousel loop>')
      end

      it 'transforms carousel with navigation parameter' do
        input = <<~MARKDOWN
          ~~~~~~navigation
          ~~~
          Slide 1
          ~~~
          ~~~
          Slide 2
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('<wa-carousel navigation>')
      end

      it 'transforms carousel with pagination parameter' do
        input = <<~MARKDOWN
          ~~~~~~pagination
          ~~~
          Slide 1
          ~~~
          ~~~
          Slide 2
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('<wa-carousel pagination>')
      end

      it 'transforms carousel with autoplay parameter' do
        input = <<~MARKDOWN
          ~~~~~~autoplay
          ~~~
          Slide 1
          ~~~
          ~~~
          Slide 2
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('<wa-carousel autoplay>')
      end

      it 'transforms carousel with mouse-dragging parameter' do
        input = <<~MARKDOWN
          ~~~~~~mouse-dragging
          ~~~
          Slide 1
          ~~~
          ~~~
          Slide 2
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('<wa-carousel mouse-dragging>')
      end

      it 'transforms carousel with vertical orientation' do
        input = <<~MARKDOWN
          ~~~~~~vertical
          ~~~
          Slide 1
          ~~~
          ~~~
          Slide 2
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('orientation="vertical"')
      end

      it 'transforms carousel with multiple boolean parameters' do
        input = <<~MARKDOWN
          ~~~~~~loop navigation pagination
          ~~~
          Slide 1
          ~~~
          ~~~
          Slide 2
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('loop')
        expect(result).to include('navigation')
        expect(result).to include('pagination')
      end

      it 'transforms carousel with mixed numeric and boolean parameters' do
        input = <<~MARKDOWN
          ~~~~~~3 2 loop navigation pagination
          ~~~
          Slide 1
          ~~~
          ~~~
          Slide 2
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('slides-per-page="3"')
        expect(result).to include('slides-per-move="2"')
        expect(result).to include('loop')
        expect(result).to include('navigation')
        expect(result).to include('pagination')
      end

      it 'transforms carousel with scroll-hint CSS property' do
        input = <<~MARKDOWN
          ~~~~~~scroll-hint:2rem
          ~~~
          Slide 1
          ~~~
          ~~~
          Slide 2
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('style="--scroll-hint: 2rem"')
      end

      it 'transforms carousel with aspect-ratio CSS property' do
        input = <<~MARKDOWN
          ~~~~~~aspect-ratio:3/2
          ~~~
          Slide 1
          ~~~
          ~~~
          Slide 2
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('style="--aspect-ratio: 3/2"')
      end

      it 'transforms carousel with slide-gap CSS property' do
        input = <<~MARKDOWN
          ~~~~~~slide-gap:1rem
          ~~~
          Slide 1
          ~~~
          ~~~
          Slide 2
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('style="--slide-gap: 1rem"')
      end

      it 'transforms carousel with multiple CSS properties' do
        input = <<~MARKDOWN
          ~~~~~~scroll-hint:2rem aspect-ratio:3/2
          ~~~
          Slide 1
          ~~~
          ~~~
          Slide 2
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('style=')
        expect(result).to include('--scroll-hint: 2rem')
        expect(result).to include('--aspect-ratio: 3/2')
      end

      it 'transforms carousel with all parameter types combined' do
        input = <<~MARKDOWN
          ~~~~~~3 2 loop navigation pagination scroll-hint:3rem
          ~~~
          Slide 1
          ~~~
          ~~~
          Slide 2
          ~~~
          ~~~
          Slide 3
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('slides-per-page="3"')
        expect(result).to include('slides-per-move="2"')
        expect(result).to include('loop')
        expect(result).to include('navigation')
        expect(result).to include('pagination')
        expect(result).to include('style="--scroll-hint: 3rem"')
      end

      it 'transforms carousel with complex slide content' do
        input = <<~MARKDOWN
          ~~~~~~navigation pagination
          ~~~
          ![Product 1](product1.jpg)

          # Amazing Product

          This is a **great** product with [more info](https://example.com).
          ~~~
          ~~~
          ![Product 2](product2.jpg)

          # Another Product

          - Feature 1
          - Feature 2
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('navigation')
        expect(result).to include('pagination')
        expect(result).to include('<img src="product1.jpg" alt="Product 1"')
        expect(result).to include('<h1')
        expect(result).to include('Amazing Product')
        expect(result).to include('<strong>great</strong>')
        expect(result).to include('<a href="https://example.com"')
        expect(result).to include('<li>Feature 1</li>')
      end

      it 'handles multiple carousels in the same content' do
        input = <<~MARKDOWN
          First carousel:
          ~~~~~~navigation
          ~~~
          Slide A1
          ~~~
          ~~~
          Slide A2
          ~~~
          ~~~~~~

          Some text in between.

          Second carousel:
          ~~~~~~3 pagination
          ~~~
          Slide B1
          ~~~
          ~~~
          Slide B2
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result.scan(/<wa-carousel\s/).length).to eq(2)
        expect(result.scan(/<wa-carousel navigation/).length).to eq(1)
        expect(result.scan(/slides-per-page="3"/).length).to eq(1)
        expect(result).to include('Slide A1')
        expect(result).to include('Slide B1')
      end
    end

    context 'with alternative syntax' do
      it 'transforms basic carousel with alternative syntax' do
        input = <<~MARKDOWN
          :::wa-carousel
          ~~~
          First slide
          ~~~
          ~~~
          Second slide
          ~~~
          :::
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('<wa-carousel>')
        expect(result).to include('First slide')
        expect(result).to include('Second slide')
      end

      it 'transforms carousel with parameters using alternative syntax' do
        input = <<~MARKDOWN
          :::wa-carousel 3 loop navigation
          ~~~
          Slide 1
          ~~~
          ~~~
          Slide 2
          ~~~
          :::
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('slides-per-page="3"')
        expect(result).to include('loop')
        expect(result).to include('navigation')
      end

      it 'transforms carousel with CSS properties using alternative syntax' do
        input = <<~MARKDOWN
          :::wa-carousel scroll-hint:2rem
          ~~~
          Slide 1
          ~~~
          ~~~
          Slide 2
          ~~~
          :::
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('style="--scroll-hint: 2rem"')
      end
    end

    context 'edge cases' do
      it 'handles single slide carousel' do
        input = <<~MARKDOWN
          ~~~~~~
          ~~~
          Only slide
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('<wa-carousel>')
        expect(result).to include('Only slide')
        expect(result.scan(/<wa-carousel-item>/).length).to eq(1)
      end

      it 'handles empty slide content' do
        input = <<~MARKDOWN
          ~~~~~~
          ~~~
          ~~~
          ~~~
          Second slide
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('<wa-carousel>')
        expect(result.scan(/<wa-carousel-item>/).length).to eq(2)
      end

      it 'preserves content outside carousel blocks' do
        input = <<~MARKDOWN
          This is regular content.

          ~~~~~~
          ~~~
          Slide content
          ~~~
          ~~~~~~

          More regular content after.
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('This is regular content.')
        expect(result).to include('More regular content after.')
        expect(result).to include('<wa-carousel>')
      end

      it 'does not transform incomplete carousel syntax' do
        input = <<~MARKDOWN
          ~~~~~~
          ~~~
          This is not closed properly
        MARKDOWN

        result = described_class.transform(input)

        expect(result).not_to include('<wa-carousel>')
        expect(result).to include('~~~~~~')
      end
    end

    context 'parameter parsing' do
      it 'ignores unknown parameters' do
        input = <<~MARKDOWN
          ~~~~~~unknown-param
          ~~~
          Slide 1
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('<wa-carousel>')
        expect(result).not_to include('unknown-param')
      end

      it 'handles parameters in any order' do
        input = <<~MARKDOWN
          ~~~~~~pagination navigation loop 3
          ~~~
          Slide 1
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('slides-per-page="3"')
        expect(result).to include('pagination')
        expect(result).to include('navigation')
        expect(result).to include('loop')
      end

      it 'handles extra whitespace in parameters' do
        input = <<~MARKDOWN
          ~~~~~~  3   loop  
          ~~~
          Slide 1
          ~~~
          ~~~~~~
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('slides-per-page="3"')
        expect(result).to include('loop')
      end
    end
  end
end
