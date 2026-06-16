# frozen_string_literal: true

require 'markawesome/code_block_protector'

module Jekyll
  module WebAwesome
    # Protects markdown fenced code blocks before Markawesome transforms
    # run, and substitutes them with Jekyll `{% highlight %}` tags after,
    # so code examples containing `:::`/`^^^`/`@@@` survive intact and
    # language-tagged blocks still render with Jekyll's syntax highlighter.
    #
    # Protection/restore is delegated to Markawesome::CodeBlockProtector;
    # the `{% highlight %}` substitution at priority 15 is Jekyll-specific
    # and stays here.
    module CodeBlockTransformer
      CODE_BLOCK_PATTERN = Markawesome::CodeBlockProtector::CODE_BLOCK_PATTERN

      @protected_blocks = {}

      class << self
        attr_reader :protected_blocks

        def clear_protected_blocks
          @protected_blocks.clear
        end

        # Check if pages transformation is enabled
        def transform_pages_enabled?(site)
          return Jekyll::WebAwesome.configuration.transform_pages if Jekyll::WebAwesome.configuration
          return site.config.dig('webawesome', 'transform_pages') if site.config.dig('webawesome', 'transform_pages') != nil

          true
        end

        # Check if documents transformation is enabled
        def transform_documents_enabled?(site)
          return Jekyll::WebAwesome.configuration.transform_documents if Jekyll::WebAwesome.configuration
          return site.config.dig('webawesome', 'transform_documents') if site.config.dig('webawesome', 'transform_documents') != nil

          true
        end

        # Protect all code blocks by converting them to placeholders via
        # Markawesome::CodeBlockProtector. The resulting token map is
        # merged into @protected_blocks so per-page placeholders survive
        # across the pre_render priority chain (50 → 15 → 10).
        def protect_all_code_blocks(content)
          protected_content, tokens = Markawesome::CodeBlockProtector.protect(content)
          @protected_blocks.merge!(tokens)
          protected_content
        end

        # Rewrite each protected fenced block to a Jekyll `{% highlight %}`
        # tag, except for blocks without a language or with `plain` — those
        # are restored verbatim. Called at priority 15, i.e. after
        # Markawesome transformers but before restore.
        def transform_code_blocks(content)
          @protected_blocks.transform_values! do |match|
            if match =~ CODE_BLOCK_PATTERN
              language = Regexp.last_match(1)
              code_content = Regexp.last_match(2).strip

              if language && language.downcase != 'plain'
                "{% highlight #{language} %}\n#{code_content}\n{% endhighlight %}"
              else
                match
              end
            else
              match
            end
          end
          content
        end

        # Restore protected code blocks using Markawesome::CodeBlockProtector,
        # then clear the per-page token map so the next page starts fresh.
        # CodeBlockProtector.protect always restarts its counter at 0, so
        # clearing between pages prevents placeholder-id collisions.
        def restore_protected_blocks(content)
          restored = Markawesome::CodeBlockProtector.restore(content, @protected_blocks)
          @protected_blocks.clear
          restored
        end

        def process(content)
          transform_code_blocks(content)
        end
      end

      if defined?(Jekyll::Hooks)
        Jekyll::Hooks.register :site, :pre_render do |_site|
          CodeBlockTransformer.clear_protected_blocks
        end

        Jekyll::Hooks.register :documents, :pre_render, priority: 50 do |document|
          next unless document.relative_path =~ /.*\.md$/i
          next unless CodeBlockTransformer.transform_documents_enabled?(document.site)

          puts "Jekyll::WebAwesome::CodeBlockTransformer protecting code blocks in document: #{document.relative_path}\n" if Plugin.debug_enabled?(document.site)
          document.content = CodeBlockTransformer.protect_all_code_blocks(document.content)
        end

        Jekyll::Hooks.register :pages, :pre_render, priority: 50 do |page|
          next unless page.relative_path =~ /.*\.md$/i
          next unless CodeBlockTransformer.transform_pages_enabled?(page.site)

          puts "Jekyll::WebAwesome::CodeBlockTransformer protecting code blocks in page: #{page.relative_path}\n" if Plugin.debug_enabled?(page.site)
          page.content = CodeBlockTransformer.protect_all_code_blocks(page.content)
        end

        Jekyll::Hooks.register :documents, :pre_render, priority: 15 do |document|
          next unless document.relative_path =~ /.*\.md$/i
          next unless CodeBlockTransformer.transform_documents_enabled?(document.site)

          puts "Jekyll::WebAwesome::CodeBlockTransformer transforming code blocks in document: #{document.relative_path}\n" if Plugin.debug_enabled?(document.site)
          document.content = CodeBlockTransformer.transform_code_blocks(document.content)
        end

        Jekyll::Hooks.register :pages, :pre_render, priority: 15 do |page|
          next unless page.relative_path =~ /.*\.md$/i
          next unless CodeBlockTransformer.transform_pages_enabled?(page.site)

          puts "Jekyll::WebAwesome::CodeBlockTransformer transforming code blocks in page: #{page.relative_path}\n" if Plugin.debug_enabled?(page.site)
          page.content = CodeBlockTransformer.transform_code_blocks(page.content)
        end

        Jekyll::Hooks.register :documents, :pre_render, priority: 10 do |document|
          next unless document.relative_path =~ /.*\.md$/i
          next unless CodeBlockTransformer.transform_documents_enabled?(document.site)

          puts "Jekyll::WebAwesome::CodeBlockTransformer restoring code blocks in document: #{document.relative_path}\n" if Plugin.debug_enabled?(document.site)
          document.content = CodeBlockTransformer.restore_protected_blocks(document.content)
        end

        Jekyll::Hooks.register :pages, :pre_render, priority: 10 do |page|
          next unless page.relative_path =~ /.*\.md$/i
          next unless CodeBlockTransformer.transform_pages_enabled?(page.site)

          puts "Jekyll::WebAwesome::CodeBlockTransformer restoring code blocks in page: #{page.relative_path}\n" if Plugin.debug_enabled?(page.site)
          page.content = CodeBlockTransformer.restore_protected_blocks(page.content)
        end
      end
    end
  end
end
