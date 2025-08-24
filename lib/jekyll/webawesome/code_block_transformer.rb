# frozen_string_literal: true

module Jekyll
  module WebAwesome
    # Transforms markdown code blocks to Jekyll highlight syntax
    module CodeBlockTransformer
      CODE_BLOCK_PATTERN = /```([a-zA-Z0-9.+#_-]+)?(\n.*?)```/m

      # Class variable to store protected blocks across hook calls
      @@protected_blocks = {}

      class << self
        def clear_protected_blocks
          @@protected_blocks.clear
        end

        # Check if pages transformation is enabled
        def transform_pages_enabled?(site)
          # Check plugin configuration first
          return Jekyll::WebAwesome.configuration.transform_pages if Jekyll::WebAwesome.configuration

          # Check site config
          return site.config.dig('webawesome', 'transform_pages') if site.config.dig('webawesome', 'transform_pages') != nil

          # Default to true
          true
        end

        # Check if documents transformation is enabled
        def transform_documents_enabled?(site)
          # Check plugin configuration first
          return Jekyll::WebAwesome.configuration.transform_documents if Jekyll::WebAwesome.configuration

          # Check site config
          return site.config.dig('webawesome', 'transform_documents') if site.config.dig('webawesome', 'transform_documents') != nil

          # Default to true
          true
        end

        # Check if a code block contains WebAwesome syntax that should be preserved
        def contains_webawesome_syntax?(content)
          # Check for WebAwesome patterns
          callout_pattern = /^:::(info|success|neutral|warning|danger)/m
          details_pattern = /^\^\^\^/m
          tabs_pattern = /^\+{6}/m

          content.match?(callout_pattern) || content.match?(details_pattern) || content.match?(tabs_pattern)
        end

        # Transform code blocks from markdown syntax to Jekyll highlight tags
        def transform_code_blocks(content)
          counter = @@protected_blocks.size

          # First pass: protect markdown code blocks that contain WebAwesome syntax
          content = content.gsub(CODE_BLOCK_PATTERN) do |match|
            language = Regexp.last_match(1)
            code_content = Regexp.last_match(2).strip

            # If this is a markdown code block containing WebAwesome syntax, protect it
            if language && language.downcase == 'markdown' && contains_webawesome_syntax?(code_content)
              placeholder = "<!--PROTECTED_WEBAWESOME_EXAMPLE_#{counter}-->"
              @@protected_blocks[placeholder] = match
              counter += 1
              placeholder
            else
              match # Leave other code blocks for normal processing
            end
          end

          # Second pass: transform remaining code blocks normally
          content.gsub(CODE_BLOCK_PATTERN) do |match|
            language = Regexp.last_match(1)
            code_content = Regexp.last_match(2).strip

            if language && language.downcase != 'plain'
              transformed = "{% highlight #{language} %}\n#{code_content}\n{% endhighlight %}"
              transformed
            else
              match # Return original block if no language or 'plain'
            end
          end
        end

        # Restore protected WebAwesome example blocks after WaElementTransformer processing
        def restore_protected_blocks(content)
          @@protected_blocks.each do |placeholder, original_block|
            content = content.gsub(placeholder, original_block)
          end
          content
        end

        def process(content)
          transform_code_blocks(content)
        end
      end

      # Register hooks directly in the transformer module
      # Clear protected blocks at start of build
      Jekyll::Hooks.register :site, :pre_render do |_site|
        CodeBlockTransformer.clear_protected_blocks
      end

      Jekyll::Hooks.register :documents, :pre_render, priority: 30 do |document|
        next unless document.relative_path =~ /.*\.md$/i
        next unless CodeBlockTransformer.transform_documents_enabled?(document.site)

        puts "Jekyll::WebAwesome::CodeBlockTransformer processing document: #{document.relative_path}\n"
        document.content = CodeBlockTransformer.transform_code_blocks(document.content)
      end

      Jekyll::Hooks.register :pages, :pre_render, priority: 30 do |page|
        next unless page.relative_path =~ /.*\.md$/i
        next unless CodeBlockTransformer.transform_pages_enabled?(page.site)

        puts "Jekyll::WebAwesome::CodeBlockTransformer processing page: #{page.relative_path}\n"
        page.content = CodeBlockTransformer.transform_code_blocks(page.content)
      end

      # Register hooks to restore protected blocks after WaElementTransformer
      Jekyll::Hooks.register :documents, :pre_render, priority: 10 do |document|
        next unless document.relative_path =~ /.*\.md$/i
        next unless CodeBlockTransformer.transform_documents_enabled?(document.site)

        puts "Jekyll::WebAwesome::CodeBlockTransformer restoring code blocks in document: #{document.relative_path}\n"
        document.content = CodeBlockTransformer.restore_protected_blocks(document.content)
      end

      Jekyll::Hooks.register :pages, :pre_render, priority: 10 do |page|
        next unless page.relative_path =~ /.*\.md$/i
        next unless CodeBlockTransformer.transform_pages_enabled?(page.site)

        puts "Jekyll::WebAwesome::CodeBlockTransformer restoring code blocks in page: #{page.relative_path}\n"
        page.content = CodeBlockTransformer.restore_protected_blocks(page.content)
      end
    end
  end
end
