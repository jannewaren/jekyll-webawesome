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

        # Protect all code blocks by converting them to placeholders
        # This prevents markdown processing from corrupting code blocks inside custom elements
        def protect_all_code_blocks(content)
          counter = @@protected_blocks.size

          content.gsub(CODE_BLOCK_PATTERN) do |match|
            placeholder = "<!--PROTECTED_CODE_BLOCK_#{counter}-->"
            @@protected_blocks[placeholder] = match
            counter += 1
            placeholder
          end
        end

        # Transform code blocks from markdown syntax to Jekyll highlight tags
        # This should be called AFTER WebAwesome transformers have processed the content
        def transform_code_blocks(content)
          # Transform code blocks that were previously protected
          @@protected_blocks.transform_values! do |match|
            if match =~ CODE_BLOCK_PATTERN
              language = Regexp.last_match(1)
              code_content = Regexp.last_match(2).strip

              if language && language.downcase != 'plain'
                "{% highlight #{language} %}\n#{code_content}\n{% endhighlight %}"
              else
                match # Return original block if no language or 'plain'
              end
            else
              match
            end
          end
          content
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
      # Wrapped in conditional to prevent errors when Jekyll::Hooks is not fully loaded
      if defined?(Jekyll::Hooks)
        # Clear protected blocks at start of build
        Jekyll::Hooks.register :site, :pre_render do |_site|
          CodeBlockTransformer.clear_protected_blocks
        end

        # STEP 1: Protect all code blocks BEFORE any transformations (highest priority)
        Jekyll::Hooks.register :documents, :pre_render, priority: 50 do |document|
          next unless document.relative_path =~ /.*\.md$/i
          next unless CodeBlockTransformer.transform_documents_enabled?(document.site)

          puts "Jekyll::WebAwesome::CodeBlockTransformer protecting code blocks in document: #{document.relative_path}\n"
          document.content = CodeBlockTransformer.protect_all_code_blocks(document.content)
        end

        Jekyll::Hooks.register :pages, :pre_render, priority: 50 do |page|
          next unless page.relative_path =~ /.*\.md$/i
          next unless CodeBlockTransformer.transform_pages_enabled?(page.site)

          puts "Jekyll::WebAwesome::CodeBlockTransformer protecting code blocks in page: #{page.relative_path}\n"
          page.content = CodeBlockTransformer.protect_all_code_blocks(page.content)
        end

        # STEP 2: Transform protected code blocks to Jekyll highlight syntax
        # This happens AFTER WebAwesome transformers (priority 20) but BEFORE restoration
        Jekyll::Hooks.register :documents, :pre_render, priority: 15 do |document|
          next unless document.relative_path =~ /.*\.md$/i
          next unless CodeBlockTransformer.transform_documents_enabled?(document.site)

          puts "Jekyll::WebAwesome::CodeBlockTransformer transforming code blocks in document: #{document.relative_path}\n"
          document.content = CodeBlockTransformer.transform_code_blocks(document.content)
        end

        Jekyll::Hooks.register :pages, :pre_render, priority: 15 do |page|
          next unless page.relative_path =~ /.*\.md$/i
          next unless CodeBlockTransformer.transform_pages_enabled?(page.site)

          puts "Jekyll::WebAwesome::CodeBlockTransformer transforming code blocks in page: #{page.relative_path}\n"
          page.content = CodeBlockTransformer.transform_code_blocks(page.content)
        end

        # STEP 3: Restore protected blocks after transformation (lowest priority)
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
end
