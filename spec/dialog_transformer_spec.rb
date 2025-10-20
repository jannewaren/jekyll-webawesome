# frozen_string_literal: true

require 'spec_helper'
require 'jekyll/webawesome/transformers/dialog_transformer'

RSpec.describe Jekyll::WebAwesome::DialogTransformer do
  describe '.transform' do
    context 'with primary syntax' do
      it 'transforms basic dialog with button and content' do
        input = <<~MARKDOWN
          ???
          Open Dialog
          >>>
          This is the dialog content.
          ???
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include("<wa-button data-dialog='open dialog-")
        expect(result).to include("'>Open Dialog</wa-button>")
        expect(result).to include("<wa-dialog id='dialog-")
        expect(result).to include('<p>This is the dialog content.</p>')
        expect(result).to include("<wa-button slot='footer' variant='primary' data-dialog='close'>Close</wa-button>")
      end

      it 'extracts label from first heading' do
        input = <<~MARKDOWN
          ???
          Open Dialog
          >>>
          # Dialog Title
          This is the content.
          ???
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include("label='Dialog Title'")
        expect(result).not_to include('<h1>Dialog Title</h1>')
        expect(result).to include('<p>This is the content.</p>')
      end

      it 'uses button text as label when no heading present' do
        input = <<~MARKDOWN
          ???
          Click Me
          >>>
          Just content here.
          ???
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include("label='Click Me'")
      end

      it 'supports light-dismiss parameter' do
        input = <<~MARKDOWN
          ???light-dismiss
          Open Dialog
          >>>
          Content here.
          ???
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('light-dismiss')
      end

      it 'always includes header with X close button' do
        input = <<~MARKDOWN
          ???
          Open Dialog
          >>>
          Content here.
          ???
        MARKDOWN

        result = described_class.transform(input)

        expect(result).not_to include('without-header')
        expect(result).to include("label='")
      end

      it 'supports width parameter with px' do
        input = <<~MARKDOWN
          ???500px
          Open Dialog
          >>>
          Content here.
          ???
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include("style='--width: 500px'")
      end

      it 'supports width parameter with vw' do
        input = <<~MARKDOWN
          ???50vw
          Open Dialog
          >>>
          Content here.
          ???
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include("style='--width: 50vw'")
      end

      it 'supports width parameter with em' do
        input = <<~MARKDOWN
          ???40em
          Open Dialog
          >>>
          Content here.
          ???
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include("style='--width: 40em'")
      end

      it 'supports width parameter with rem' do
        input = <<~MARKDOWN
          ???30rem
          Open Dialog
          >>>
          Content here.
          ???
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include("style='--width: 30rem'")
      end

      it 'supports width parameter with percentage' do
        input = <<~MARKDOWN
          ???80%
          Open Dialog
          >>>
          Content here.
          ???
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include("style='--width: 80%'")
      end

      it 'supports combining light-dismiss and width' do
        input = <<~MARKDOWN
          ???light-dismiss 600px
          Open Dialog
          >>>
          Content here.
          ???
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('light-dismiss')
        expect(result).to include("style='--width: 600px'")
      end

      it 'supports combining light-dismiss and width' do
        input = <<~MARKDOWN
          ???light-dismiss 45em
          Open Dialog
          >>>
          Content here.
          ???
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('light-dismiss')
        expect(result).not_to include('without-header')
        expect(result).to include("style='--width: 45em'")
      end

      it 'always includes header even with multiple parameters' do
        input = <<~MARKDOWN
          ???light-dismiss 700px
          Open Dialog
          >>>
          Content here.
          ???
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('light-dismiss')
        expect(result).not_to include('without-header')
        expect(result).to include("label='")
        expect(result).to include("style='--width: 700px'")
      end

      it 'generates unique IDs for different dialogs' do
        input = <<~MARKDOWN
          ???
          First Dialog
          >>>
          First content
          ???

          ???
          Second Dialog
          >>>
          Second content
          ???
        MARKDOWN

        result = described_class.transform(input)

        # Extract dialog IDs
        ids = result.scan(/id='(dialog-[a-f0-9]+)'/).flatten

        expect(ids.length).to eq(2)
        expect(ids[0]).not_to eq(ids[1])
      end

      it 'generates consistent IDs for same content' do
        input1 = <<~MARKDOWN
          ???
          Open Dialog
          >>>
          Same content
          ???
        MARKDOWN

        input2 = <<~MARKDOWN
          ???
          Open Dialog
          >>>
          Same content
          ???
        MARKDOWN

        result1 = described_class.transform(input1)
        result2 = described_class.transform(input2)

        id1 = result1.match(/id='(dialog-[a-f0-9]+)'/)[1]
        id2 = result2.match(/id='(dialog-[a-f0-9]+)'/)[1]

        expect(id1).to eq(id2)
      end

      it 'preserves markdown formatting in content' do
        input = <<~MARKDOWN
          ???
          Open Dialog
          >>>
          This has **bold** and *italic* text with [a link](https://example.com).
          ???
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('<strong>bold</strong>')
        expect(result).to include('<em>italic</em>')
        expect(result).to include('<a href="https://example.com">a link</a>')
      end

      it 'escapes HTML in button text' do
        input = <<~MARKDOWN
          ???
          Open <script>alert('xss')</script>
          >>>
          Content
          ???
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('&lt;script&gt;')
        expect(result).to include('alert(&#39;xss&#39;)')
        expect(result).not_to match(/<script>alert/)
      end

      it 'escapes quotes in label' do
        input = <<~MARKDOWN
          ???
          Open Dialog
          >>>
          # Title with "quotes" and 'apostrophes'
          Content
          ???
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include("label='Title with &quot;quotes&quot; and &#39;apostrophes&#39;'")
      end
    end

    context 'with alternative syntax' do
      it 'transforms basic dialog' do
        input = <<~MARKDOWN
          :::wa-dialog
          Open Dialog
          >>>
          This is the dialog content.
          :::
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include("<wa-button data-dialog='open dialog-")
        expect(result).to include("'>Open Dialog</wa-button>")
        expect(result).to include("<wa-dialog id='dialog-")
        expect(result).to include('<p>This is the dialog content.</p>')
      end

      it 'supports light-dismiss parameter' do
        input = <<~MARKDOWN
          :::wa-dialog light-dismiss
          Open Dialog
          >>>
          Content here.
          :::
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('light-dismiss')
      end

      it 'supports width parameter' do
        input = <<~MARKDOWN
          :::wa-dialog 600px
          Open Dialog
          >>>
          Content here.
          :::
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include("style='--width: 600px'")
      end

      it 'extracts label from first heading' do
        input = <<~MARKDOWN
          :::wa-dialog
          Open Dialog
          >>>
          # Important Notice
          This is important.
          :::
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include("label='Important Notice'")
      end
    end

    context 'with mixed syntax in same content' do
      it 'transforms both primary and alternative syntax' do
        input = <<~MARKDOWN
          ???
          First Dialog
          >>>
          Primary syntax
          ???

          :::wa-dialog
          Second Dialog
          >>>
          Alternative syntax
          :::
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include("'>First Dialog</wa-button>")
        expect(result).to include("'>Second Dialog</wa-button>")
        expect(result).to include('<p>Primary syntax</p>')
        expect(result).to include('<p>Alternative syntax</p>')
      end

      it 'transforms consecutive alternative syntax blocks' do
        input = <<~MARKDOWN
          :::wa-dialog
          First Alternative
          >>>
          First content
          :::

          :::wa-dialog
          Second Alternative
          >>>
          Second content
          :::
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include("'>First Alternative</wa-button>")
        expect(result).to include("'>Second Alternative</wa-button>")
        expect(result).to include('<p>First content</p>')
        expect(result).to include('<p>Second content</p>')
      end
    end

    context 'with complex content' do
      it 'handles lists and code blocks' do
        input = <<~MARKDOWN
          ???
          Show Info
          >>>
          # Features

          Here are the features:

          - Feature 1
          - Feature 2
          - Feature 3

          And some code:

          ```ruby
          puts "Hello"
          ```
          ???
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include('<ul>')
        expect(result).to include('<li>Feature 1</li>')
        expect(result).to include('<code')
        expect(result).to include('puts "Hello"')
      end

      it 'handles multiple paragraphs' do
        input = <<~MARKDOWN
          ???
          Read More
          >>>
          First paragraph.

          Second paragraph.

          Third paragraph.
          ???
        MARKDOWN

        result = described_class.transform(input)

        expect(result.scan(/<p>/).length).to be >= 3
      end
    end

    context 'edge cases' do
      it 'handles dialog with minimal content' do
        input = <<~MARKDOWN
          ???
          OK
          >>>
          OK
          ???
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include("<wa-button data-dialog='open dialog-")
        expect(result).to include("'>OK</wa-button>")
        expect(result).to include('<wa-dialog')
      end

      it 'does not transform incomplete syntax' do
        input = <<~MARKDOWN
          ???
          Missing separator and end
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to eq(input)
      end

      it 'handles decimal width values' do
        input = <<~MARKDOWN
          ???45.5em
          Open Dialog
          >>>
          Content here.
          ???
        MARKDOWN

        result = described_class.transform(input)

        expect(result).to include("style='--width: 45.5em'")
      end
    end
  end
end
