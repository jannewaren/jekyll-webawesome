# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)

## [Unreleased]

- Placeholder

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
