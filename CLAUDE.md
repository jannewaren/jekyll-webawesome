# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

jekyll-webawesome is a Ruby gem (Jekyll plugin) that transforms custom Markdown syntax into [Web Awesome](https://webawesome.com/) web components. The actual Markdown-to-HTML transformation logic lives in a separate gem called [markawesome](https://github.com/jannewaren/markawesome) — this gem is the Jekyll integration layer.

## Common Commands

```bash
# Install dependencies
bundle install

# Run tests
bundle exec rake spec

# Run a single test file
bundle exec rspec spec/plugin_spec.rb

# Run lint
bundle exec rubocop

# Run both tests and lint (default rake task)
bundle exec rake

# Build the gem
gem build jekyll-webawesome.gemspec

# Run the examples site locally
cd examples && bundle install && bundle exec jekyll serve
```

## Architecture

### Hook-based Pipeline

The plugin works entirely through Jekyll's `pre_render` hooks on both `:pages` and `:documents`. Processing happens in a priority-ordered pipeline:

1. **Priority 50** — `CodeBlockTransformer` protects code blocks by replacing them with placeholders (prevents Markawesome from transforming code examples)
2. **Default priority** — `Plugin` delegates to `Markawesome::Transformer.process()` for the actual Markdown→Web Awesome HTML conversion
3. **Priority 15** — `CodeBlockTransformer` converts protected code blocks to Jekyll `{% highlight %}` tags
4. **Priority 10** — `CodeBlockTransformer` restores placeholders back into the content

### Key Files

- `lib/jekyll/webawesome.rb` — Main module, `Configuration` class, syncs config to Markawesome
- `lib/jekyll/webawesome/plugin.rb` — Jekyll hooks registration, config checking, calls `Markawesome::Transformer.process()`
- `lib/jekyll/webawesome/code_block_transformer.rb` — Protect/transform/restore pipeline for code blocks
- `lib/jekyll/webawesome/version.rb` — Gem version constant

### Configuration

The plugin reads configuration from two sources (plugin config takes precedence):

- **Programmatic**: `Jekyll::WebAwesome.configure { |c| ... }`
- **Site config**: `_config.yml` under the `webawesome:` key

Key options: `debug`, `transform_pages`, `transform_documents`, `image_dialog`.

### Dependencies

- **markawesome** gem — contains all the transformation logic (pattern matching, HTML generation for each component type)
- **Jekyll** >= 3.7, < 5.0
- **Kramdown** >= 2.0

### Testing

Tests use RSpec and mock Jekyll's `site` object with doubles. Tests cover configuration, plugin behavior, and code block transformation. No integration tests that run a full Jekyll build.
