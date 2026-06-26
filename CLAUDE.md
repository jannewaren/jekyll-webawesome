# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

jekyll-webawesome is a Ruby gem (Jekyll plugin) that transforms custom Markdown syntax into [Web Awesome](https://webawesome.com/) web components. The actual Markdown-to-HTML transformation logic lives in a separate gem called [markawesome](https://github.com/jannewaren/markawesome) — this gem is the Jekyll integration layer.

## The markawesome ecosystem — keep the syntax in sync

The Markawesome-flavoured Markdown syntax spans **five repositories that must
stay in lockstep**:

| Repo | Role | Stack | Registry |
|------|------|-------|----------|
| `markawesome` | **Authors** the syntax (engine) | Ruby | RubyGems |
| `markawesome-js` | **Authors** the syntax (engine) | TypeScript / Node | npm |
| `jekyll-webawesome` | **Uses** it (Jekyll integration) | Ruby | RubyGems |
| `eleventy-plugin-webawesome` | **Uses** it (Eleventy integration) | Node | npm |
| `markawesome-vscode` | **Produces** it (snippets/completions/validation) | TypeScript | VS Code Marketplace |

**This repo's role:** **uses** the syntax — it consumes the Ruby `markawesome`
engine and defines no syntax of its own. Syntax changes belong in the engines, not
here.

**Sync rule:** any change to the Markawesome Markdown syntax must land in **both
engines** (`markawesome` *and* `markawesome-js`) so the Ruby and Node worlds accept
identical input, **and** in `markawesome-vscode` so the editor emits it. The VS Code
extension is shared across both worlds, so it may only produce syntax that **both**
engines support. Confirm the engines still agree via `markawesome-js`'s
`test/parity-corpus.test.ts` plus the Ruby specs in `markawesome/spec/`.

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

## Development & Release Workflow (markawesome + jekyll-webawesome)

markawesome (the transformation engine) and jekyll-webawesome (this Jekyll
integration) are developed together. Component markup changes are made in
markawesome and validated end-to-end through this gem's `examples/` site before
either gem is released. Follow this order:

1. **Change markawesome first.** Make the transformer change in the markawesome
   repo, update its specs, add a `CHANGELOG.md` entry, and commit.
2. **Use local markawesome from jekyll-webawesome.** Temporarily point this gem
   at the working copy by switching the root `Gemfile` to
   `gem 'markawesome', path: '../markawesome'`, then `bundle install`.
   (`examples/Gemfile` already uses the local path.)
3. **Add real test cases to the examples site.** Add cases to `examples/index.md`
   that exercise the change — not synthetic snippets, but markup that would
   visibly break or render wrong without it.
4. **Check them visually.** Run `cd examples && bundle exec jekyll serve` and
   verify the rendered components in a browser. Confirm the change actually
   renders (measure/inspect the live DOM), not just that the HTML attribute is
   present. The Web Awesome version is set by the CDN kit configured on
   webawesome.com — the kit URL in `examples/_layouts/default.html` is opaque,
   so validate against whatever version that kit currently serves.
5. **Release markawesome.** Bump `lib/markawesome/version.rb`, finalize its
   CHANGELOG, `gem build`, and `gem push` to RubyGems.
6. **Update the required markawesome version here.** Bump the `~> X.Y`
   constraint in `jekyll-webawesome.gemspec`, restore the root `Gemfile` from
   the local path back to the published `~> X.Y`, bump
   `lib/jekyll/webawesome/version.rb`, add a CHANGELOG entry, and commit.
7. **Release jekyll-webawesome.** `gem build jekyll-webawesome.gemspec` and
   `gem push` to RubyGems.

> **Push every release commit to git immediately after `gem push`.** A gem
> published to RubyGems but never pushed to the repo leaves clones diverged: the
> version bump and any code in that release become invisible to other machines,
> and the next release collides on the version number.

## Releases are tagged to match the published version

Every version published to a registry gets a matching **GitHub Release**, so the
repo's releases line up 1:1 with what's installable:

1. Tag the released commit `vX.Y.Z` — the same version as
   `lib/jekyll/webawesome/version.rb`.
2. Push the commit and the tag.
3. `gh release create vX.Y.Z` with notes drawn from `CHANGELOG.md`.

The GitHub Release tag **must equal** the version published to RubyGems.
