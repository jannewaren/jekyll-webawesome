# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)

## [Unreleased]

## [0.2.0] - 2025-09-03

### Added

- Configuration options to control transformation scope
  - `transform_pages` - Enable/disable transformations for pages (default: true)
  - `transform_documents` - Enable/disable transformations for documents/posts (default: true)
  - Can be configured via `_config.yml` or programmatically
- Support for Comparison component (`|||` or `:::wa-comparison`)
  - Optional position parameter to set initial slider position (`|||25` sets position to 25%)
  - Requires exactly two images for before/after comparison

## [0.1.0] - 2025-08-09

### Added

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
