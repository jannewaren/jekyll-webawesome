# frozen_string_literal: true

RSpec.describe Jekyll::WebAwesome::TabsTransformer do
  describe '.transform' do
    it 'transforms basic tab group' do
      markdown = "++++++\n+++ Tab 1\nContent 1\n+++\n+++ Tab 2\nContent 2\n+++\n++++++"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-tab-group placement="top">')
      expect(result).to include('<wa-tab panel="tab-1">Tab 1</wa-tab>')
      expect(result).to include('<wa-tab panel="tab-2">Tab 2</wa-tab>')
      expect(result).to include('<wa-tab-panel name="tab-1"><p>Content 1</p>')
      expect(result).to include('<wa-tab-panel name="tab-2"><p>Content 2</p>')
      expect(result).to include('</wa-tab-group>')
    end

    it 'transforms tab group with start placement' do
      markdown = "++++++start\n+++ Tab 1\nContent 1\n+++\n++++++"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-tab-group placement="start">')
    end

    it 'transforms tab group with bottom placement' do
      markdown = "++++++bottom\n+++ Tab 1\nContent 1\n+++\n++++++"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-tab-group placement="bottom">')
    end

    it 'transforms tab group with end placement' do
      markdown = "++++++end\n+++ Tab 1\nContent 1\n+++\n++++++"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-tab-group placement="end">')
    end

    it 'defaults to top placement when none specified' do
      markdown = "++++++\n+++ Tab 1\nContent 1\n+++\n++++++"
      result = described_class.transform(markdown)

      expect(result).to include('<wa-tab-group placement="top">')
    end

    it 'handles multiple tabs with complex content' do
      markdown = <<~MD
        ++++++
        +++ First Tab
        # Heading in tab
        Some content here.
        +++
        +++ Second Tab
        - List item 1
        - List item 2
        +++
        +++ Third Tab
        **Bold text** and *italic text*.
        +++
        ++++++
      MD

      result = described_class.transform(markdown)

      expect(result).to include('<wa-tab panel="tab-1">First Tab</wa-tab>')
      expect(result).to include('<wa-tab panel="tab-2">Second Tab</wa-tab>')
      expect(result).to include('<wa-tab panel="tab-3">Third Tab</wa-tab>')
      expect(result).to include('<h1 id="heading-in-tab">Heading in tab</h1>')
      expect(result).to include('<li>List item 1</li>')
      expect(result).to include('<strong>Bold text</strong>')
    end

    it 'does not transform incomplete tab syntax' do
      markdown = "++++++\n+++ Tab 1\nContent 1\n++++++"
      result = described_class.transform(markdown)

      expect(result).to eq(markdown)
    end
  end
end
