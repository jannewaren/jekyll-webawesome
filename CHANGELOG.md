# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)

## [Unreleased]

- Placeholder

## [0.9.0] - 2026-02-09

### Added

- **Icon slot syntax** for components via markawesome 0.4.0:
  - Buttons: `icon:name` (start) and `icon:end:name` for start/end icon slots
  - Callouts: `icon:name` to override default variant icons
  - Details: `icon:expand:name` and `icon:collapse:name` for custom toggle icons
  - Tags: `icon:name` for inline content icons (block and inline syntax)
- Example site updated with icon demonstrations for all supported components

### Fixed

- Removed `margin-top` from `wa-icon` in example site CSS that caused misaligned icons inside components

### Changed

- Updated `markawesome` dependency to `~> 0.4`

## [0.8.0] - 2026-02-08

### Changed

- Updated `markawesome` dependency to `~> 0.3` to bring in comprehensive attribute improvements
- All transformer enhancements from markawesome 0.3.0 are now available:
  - Tag: variant, size, appearance, pill, and removable attributes
  - Tabs: activation, active, and no-scroll-controls attributes
  - Details: disabled, open, and name attributes
  - Copy Button: variant, size, appearance, and disabled attributes
  - Carousel: autoplay-interval attribute
  - Card: orientation attribute
  - Consistent AttributeParser usage across all major transformers

### Improved

- More flexible, order-independent parameter syntax for all components
- Better attribute handling consistency across transformers

## [0.7.1] - 2025-11-07

### Fixed

- Fix the debug mode, all debug output was always shown regardless of config setting

## [0.7.0] - 2025-10-27

### Changed

- **BREAKING CHANGE**: Extracted all transformation logic into separate `markawesome` gem
- Jekyll WebAwesome now depends on `markawesome ~> 0.1` for transformation logic
- Configuration is now synced from Jekyll to Markawesome automatically
- Hook registration wrapped in conditional checks to prevent test environment errors

### Removed

- All transformer classes moved to `markawesome` gem
- Individual transformer spec files (now in `markawesome` gem)

### Added

- Configuration sync method to pass Jekyll config to Markawesome
- Conditional `if defined?(Jekyll::Hooks)` guards around hook registrations
- Support for passing `image_dialog` options to Markawesome transformer

### Technical Details

This release extracts the Markdown-to-Web Awesome transformation engine into a framework-agnostic gem called `markawesome`. The `jekyll-webawesome` gem now focuses solely on Jekyll integration (hooks, plugin registration, code block handling), while `markawesome` handles all component transformations.

Benefits:

- Transformation logic can now be used with other static site generators (Hugo, Middleman, etc.)
- Better separation of concerns
- Easier testing and maintenance
- No breaking changes for end users (syntax remains the same)

Migration:

- Update your Gemfile: `gem 'jekyll-webawesome', '~> 0.5.0'`
- Run `bundle update jekyll-webawesome`
- No configuration changes needed - everything works the same

## [0.6.0] - 2025-10-23

- Support inline wa-tag components

## [0.6.0] - 2025-10-22

- Support for wa-carousel component

## [0.5.4] - 2025-10-20

- Support for default width for the image_dialog like

```yaml
webawesome:
  image_dialog:
    enabled: true
    default_width: 90vh
```

## [0.5.3] - 2025-10-20

- Always have a header with X button on the dialogs

## [0.5.2] - 2025-10-20

- Fix the image dialog auto-transformation feature protection again

## [0.5.1] - 2025-10-20

- Image dialog auto-transformation feature fix: protect comparison components

## [0.5.0] - 2025-10-20

- Add support for wa-dialog component
- Image dialog auto-transformation feature
  - New `image_dialog` configuration option (opt-in, default: false)
  - Automatically transforms markdown images into clickable dialogs
  - Support for custom dialog width via title attribute (e.g., `"50%"`, `"800px"`, `"90vw"`)
  - Opt-out mechanism via `"nodialog"` in title attribute

## [0.4.1] - 2025-10-02

- Code blocks inside custom elements (wa-details, wa-callout, etc.) are now properly protected from markdown processing
  - Previously, code blocks would be corrupted with HTML entities and extra `<p>` tags when nested inside custom elements

## [0.4.0] - 2025-09-29

- Support for icon placement in wa-details component

## [0.3.0] - 2025-09-29

- Support for wa-copy-button component (`<<<...<<<` or `:::wa-copy-button`)

## [0.2.1] - 2025-09-23

- Fixed issues with icon transformation messing up code blocks and inline code

## [0.2.0] - 2025-09-03

- Configuration options to control transformation scope
  - `transform_pages` - Enable/disable transformations for pages (default: true)
  - `transform_documents` - Enable/disable transformations for documents/posts (default: true)
  - Can be configured via `_config.yml` or programmatically
- Support for Comparison component (`|||` or `:::wa-comparison`)
  - Optional position parameter to set initial slider position (`|||25` sets position to 25%)
  - Requires exactly two images for before/after comparison

## [0.1.0] - 2025-08-09

- Initial release of jekyll-webawesome gem
- Support for Badge components (`!!!variant` or `:::wa-badge variant`)
- Support for Button components (`%%%variant` or `:::wa-button variant`)
- Support for Callout components (`:::info`, `:::success`, `:::warning`, `:::danger`, `:::neutral` or `:::wa-callout variant`)
- Support for Card components (`===` or `:::wa-card`)
- Support for Details/Summary components (`^^^...>>>...^^^` or `:::wa-details`)
- Support for Icon components (`$$$icon-name` or `:::wa-icon name`)
- Support for Tag components (`@@@variant` or `:::wa-tag variant`)
- Support for Tab Group components (`++++++...++++++` or `:::wa-tabs`)
- Automatic Jekyll hooks integration
- Dual syntax support (primary shorthand and alternative explicit syntax) for all components
