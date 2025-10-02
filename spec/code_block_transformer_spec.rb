# frozen_string_literal: true

RSpec.describe Jekyll::WebAwesome::CodeBlockTransformer do
  before(:each) do
    # Clear protected blocks before each test
    described_class.clear_protected_blocks
  end

  describe '.protect_all_code_blocks' do
    it 'protects a simple code block' do
      markdown = "Some text\n```ruby\nputs 'hello'\n```\nMore text"
      result = described_class.protect_all_code_blocks(markdown)

      expect(result).to include('<!--PROTECTED_CODE_BLOCK_0-->')
      expect(result).not_to include('```ruby')
      expect(result).not_to include("puts 'hello'")
    end

    it 'protects multiple code blocks' do
      markdown = "```ruby\ncode1\n```\n\nSome text\n\n```javascript\ncode2\n```"
      result = described_class.protect_all_code_blocks(markdown)

      expect(result).to include('<!--PROTECTED_CODE_BLOCK_0-->')
      expect(result).to include('<!--PROTECTED_CODE_BLOCK_1-->')
      expect(result).not_to include('```ruby')
      expect(result).not_to include('```javascript')
    end

    it 'protects XML code blocks' do
      markdown = "```xml\n<?xml version=\"1.0\"?>\n<root></root>\n```"
      result = described_class.protect_all_code_blocks(markdown)

      expect(result).to include('<!--PROTECTED_CODE_BLOCK_0-->')
      expect(result).not_to include('<?xml')
    end

    it 'protects code blocks with no language specified' do
      markdown = "```\nplain code\n```"
      result = described_class.protect_all_code_blocks(markdown)

      expect(result).to include('<!--PROTECTED_CODE_BLOCK_0-->')
      expect(result).not_to include('plain code')
    end
  end

  describe '.transform_code_blocks' do
    it 'transforms protected Ruby code blocks to Jekyll highlight syntax' do
      markdown = "```ruby\nputs 'hello'\n```"
      protected = described_class.protect_all_code_blocks(markdown)
      result = described_class.transform_code_blocks(protected)

      # After transformation, protected blocks should still be placeholders
      # but their stored values should be transformed
      expect(result).to include('<!--PROTECTED_CODE_BLOCK_0-->')
    end

    it 'does not transform plain code blocks' do
      markdown = "```plain\nplain text\n```"
      protected = described_class.protect_all_code_blocks(markdown)
      described_class.transform_code_blocks(protected)
      result = described_class.restore_protected_blocks(protected)

      expect(result).to include('```plain')
      expect(result).not_to include('{% highlight')
    end

    it 'transforms multiple code blocks independently' do
      markdown = "```ruby\nruby_code\n```\n\n```javascript\njs_code\n```"
      protected = described_class.protect_all_code_blocks(markdown)
      described_class.transform_code_blocks(protected)
      result = described_class.restore_protected_blocks(protected)

      expect(result).to include('{% highlight ruby %}')
      expect(result).to include('{% highlight javascript %}')
    end
  end

  describe '.restore_protected_blocks' do
    it 'restores protected code blocks to their final form' do
      markdown = "```ruby\nputs 'hello'\n```"
      protected = described_class.protect_all_code_blocks(markdown)
      described_class.transform_code_blocks(protected)
      result = described_class.restore_protected_blocks(protected)

      expect(result).to include('{% highlight ruby %}')
      expect(result).to include("puts 'hello'")
      expect(result).to include('{% endhighlight %}')
      expect(result).not_to include('<!--PROTECTED_CODE_BLOCK')
    end

    it 'restores multiple protected blocks' do
      markdown = "```ruby\ncode1\n```\n\nText\n\n```javascript\ncode2\n```"
      protected = described_class.protect_all_code_blocks(markdown)
      described_class.transform_code_blocks(protected)
      result = described_class.restore_protected_blocks(protected)

      expect(result).to include('{% highlight ruby %}')
      expect(result).to include('{% highlight javascript %}')
      expect(result).not_to include('<!--PROTECTED_CODE_BLOCK')
    end
  end

  describe 'integration with custom elements' do
    it 'protects code blocks inside wa-details elements' do
      markdown = <<~MARKDOWN
        ^^^outlined
        Example Code
        >>>
        Here is some code:

        ```xml
        <?xml version="1.0"?>
        <root>
          <element>value</element>
        </root>
        ```

        That was the code.
        ^^^
      MARKDOWN

      # Step 1: Protect all code blocks
      protected = described_class.protect_all_code_blocks(markdown)
      expect(protected).to include('<!--PROTECTED_CODE_BLOCK_0-->')
      expect(protected).not_to include('<?xml')

      # Step 2: Transform the wa-details syntax (simulating DetailsTransformer)
      # After protection, the placeholder should remain in the content
      expect(protected).to include('<!--PROTECTED_CODE_BLOCK_0-->')

      # Step 3: Transform code blocks
      described_class.transform_code_blocks(protected)

      # Step 4: Restore protected blocks
      result = described_class.restore_protected_blocks(protected)

      expect(result).to include('{% highlight xml %}')
      expect(result).to include('<?xml version="1.0"?>')
      expect(result).not_to include('&lt;?xml')
      expect(result).not_to include('<p><?xml')
    end

    it 'handles multiple code blocks in one wa-details element' do
      markdown = <<~MARKDOWN
        ^^^outlined
        Multiple Examples
        >>>
        First example:

        ```ruby
        puts 'first'
        ```

        Second example:

        ```javascript
        console.log('second');
        ```
        ^^^
      MARKDOWN

      protected = described_class.protect_all_code_blocks(markdown)
      expect(protected).to include('<!--PROTECTED_CODE_BLOCK_0-->')
      expect(protected).to include('<!--PROTECTED_CODE_BLOCK_1-->')

      described_class.transform_code_blocks(protected)
      result = described_class.restore_protected_blocks(protected)

      expect(result).to include('{% highlight ruby %}')
      expect(result).to include('{% highlight javascript %}')
    end

    it 'protects code blocks inside wa-callout elements' do
      markdown = <<~MARKDOWN
        :::warning
        **Important:** File upload must use multipart/form-data.

        Example:

        ```bash
        curl -X POST -F "file=@document.pdf"
        ```
        :::
      MARKDOWN

      protected = described_class.protect_all_code_blocks(markdown)
      expect(protected).to include('<!--PROTECTED_CODE_BLOCK_0-->')

      described_class.transform_code_blocks(protected)
      result = described_class.restore_protected_blocks(protected)

      expect(result).to include('{% highlight bash %}')
      expect(result).to include('curl -X POST')
    end

    it 'protects code blocks inside nested structures' do
      markdown = <<~MARKDOWN
        ^^^outlined
        Details with nested callout
        >>>
        Some text

        :::info
        Information with code:

        ```python
        def hello():
            print("world")
        ```
        :::

        More text
        ^^^
      MARKDOWN

      protected = described_class.protect_all_code_blocks(markdown)
      expect(protected).to include('<!--PROTECTED_CODE_BLOCK_0-->')

      described_class.transform_code_blocks(protected)
      result = described_class.restore_protected_blocks(protected)

      expect(result).to include('{% highlight python %}')
      expect(result).to include('def hello():')
    end

    it 'preserves special characters in protected code blocks' do
      markdown = <<~MARKDOWN
        ^^^outlined
        XML Example
        >>>
        ```xml
        <lb:LetterBundle xmlns:lb="urn:itella-letterbundle-v0x4">
          <lb:Sender ovtID="003712345678"/>
        </lb:LetterBundle>
        ```
        ^^^
      MARKDOWN

      protected = described_class.protect_all_code_blocks(markdown)
      described_class.transform_code_blocks(protected)
      result = described_class.restore_protected_blocks(protected)

      expect(result).to include('xmlns:lb="urn:itella-letterbundle-v0x4"')
      expect(result).to include('ovtID="003712345678"')
      expect(result).not_to include('&lt;lb:')
      expect(result).not_to include('&quot;')
    end
  end

  describe 'full workflow simulation' do
    it 'correctly processes XML schema definition inside wa-details' do
      markdown = <<~MARKDOWN
        ^^^outlined
        Example of XML Schema Definition
        >>>
        ```xml
        <xs:complexType name="InvoicedObjectIDType">
            <xs:simpleContent>
              <xs:extension base="genericStringType1_70">
                <xs:attribute name="SchemeID" type="untdid1153"/>
              </xs:extension>
            </xs:simpleContent>
          </xs:complexType>
          <xs:simpleType name="capAZ09">
            <xs:restriction base="xs:NMTOKEN">
              <xs:pattern value="[A-Z0-9]*"/>
            </xs:restriction>
          </xs:simpleType>
          <xs:simpleType name="untdid1_3_AZ09">
            <xs:restriction base="capAZ09">
              <xs:minLength value="1"/>
              <xs:maxLength value="3"/>
            </xs:restriction>
          </xs:simpleType>
          <xs:simpleType name="untdid1001">
            <xs:restriction base="untdid1_3_AZ09"/>
          </xs:simpleType>
          <xs:simpleType name="untdid1153">
            <xs:restriction base="untdid1_3_AZ09"/>
          </xs:simpleType>
          <xs:simpleType name="untdid2005">
            <xs:restriction base="untdid1_3_AZ09"/>
          </xs:simpleType>
          <xs:simpleType name="untdid4461">
            <xs:restriction base="untdid1_3_AZ09"/>
          </xs:simpleType>
          <xs:simpleType name="untdid5189">
            <xs:restriction base="untdid1_3_AZ09"/>
          </xs:simpleType>
          <xs:simpleType name="untdid5305">
            <xs:restriction base="untdid1_3_AZ09"/>
          </xs:simpleType>
          <xs:simpleType name="untdid7143">
            <xs:restriction base="untdid1_3_AZ09"/>
          </xs:simpleType>
          <xs:simpleType name="untdid7161">
            <xs:restriction base="untdid1_3_AZ09"/>
          </xs:simpleType>
          <xs:simpleType name="ElectronicAddrSchemeIdType">
            <xs:restriction base="xs:NMTOKEN">
              <xs:minLength value="1"/>
              <xs:maxLength value="10"/>
            </xs:restriction>
          </xs:simpleType>
          <xs:complexType name="ElectronicAddrIdType">
            <xs:simpleContent>
              <xs:extension base="genericStringType2_35">
                <xs:attribute name="SchemeID" type="ElectronicAddrSchemeIdType"/>
              </xs:extension>
            </xs:simpleContent>
          </xs:complexType>
          <xs:simpleType name="unitCodeUN">
            <xs:restriction base="xs:NMTOKEN">
              <xs:pattern value="[A-Z0-9]{2,3}"/>
            </xs:restriction>
          </xs:simpleType>
        ```
        ^^^
      MARKDOWN

      # Simulate the full transformation workflow
      # Step 1: Protect all code blocks (priority 50)
      content = described_class.protect_all_code_blocks(markdown)

      # Step 2: Transform wa-details (priority 20 - done by Transformer)
      content = Jekyll::WebAwesome::DetailsTransformer.transform(content)

      # At this point, the code block should still be protected
      expect(content).to include('<!--PROTECTED_CODE_BLOCK_0-->')
      expect(content).to include('<wa-details')

      # Step 3: Transform code blocks (priority 15)
      content_after_transform = described_class.transform_code_blocks(content)

      # Step 4: Restore protected blocks (priority 10)
      result = described_class.restore_protected_blocks(content_after_transform)

      # Verify the final result
      expect(result).to include('<wa-details')
      expect(result).to include('{% highlight xml %}')
      expect(result).to include('<xs:complexType name="InvoicedObjectIDType">')
      expect(result).to include('<xs:attribute name="SchemeID" type="untdid1153"/>')
      expect(result).to include('<xs:pattern value="[A-Z0-9]*"/>')
      expect(result).to include('{% endhighlight %}')

      # Make sure there are no HTML entities in the code block
      expect(result).not_to include('&lt;xs:')
      expect(result).not_to include('&quot;')

      # Make sure the code block itself doesn't have <p> tags wrapping it
      # (the summary can have <p> tags, that's normal for markdown)
      code_section = result[/{% highlight xml %}.*?{% endhighlight %}/m]
      expect(code_section).not_to include('<p>')
      expect(code_section).not_to include('</p>')

      expect(result).not_to include('<!--PROTECTED_CODE_BLOCK')
    end
  end
end
