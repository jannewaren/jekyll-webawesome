# frozen_string_literal: true

RSpec.describe Jekyll::WebAwesome::Transformer do
  describe '.process' do
    it 'processes all transformations in sequence' do
      markdown = <<~MD
        :::info
        This is info
        :::

        ^^^
        Summary
        >>>
        Details
        ^^^

        ++++++
        +++ Tab 1
        Content 1
        +++
        ++++++
      MD

      result = described_class.process(markdown)

      expect(result).to include('<wa-callout variant="brand">')
      expect(result).to include('<wa-details appearance=\'outlined\'>')
      expect(result).to include('<wa-tab-group placement="top">')
    end

    it 'processes complex nested content correctly' do
      markdown = <<~MD
        :::warning
        # Warning Heading
        This is a **warning** with *formatted* text.
        :::

        ^^^filled
        ## Summary with formatting
        Click to see more
        >>>
        ### Details section
        - Item 1
        - Item 2
        ^^^

        ++++++bottom
        +++ Code Example
        ```ruby
        def hello
          puts "world"
        end
        ```
        +++ Output
        ```
        world
        ```
        +++
        ++++++
      MD

      result = described_class.process(markdown)

      # Verify all components are processed
      expect(result).to include('<wa-callout variant="warning">')
      expect(result).to include('<wa-details appearance=\'filled\'>')
      expect(result).to include('<wa-tab-group placement="bottom">')

      # Verify markdown processing within components
      expect(result).to include('<h1 id="warning-heading">Warning Heading</h1>')
      expect(result).to include('<strong>warning</strong>')
      expect(result).to include('<h2 id="summary-with-formatting">Summary with formatting</h2>')
      expect(result).to include('<h3 id="details-section">Details section</h3>')
    end
  end
end
