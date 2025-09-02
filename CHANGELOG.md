# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)

## [Unreleased]

### Added

- Configuration options to control transformation scope
  - `transform_pages` - Enable/disable transformations for pages (default: true)
  - `transform_documents` - Enable/disable transformations for documents/posts (default: true)
  - Can be configured via `_config.yml` or programmatically
- Support Comparison component (`>>>` or `:::wa-comparison`)

## [0.1.0] - 2025-08-09

### Added

- Initial release of jekyll-webawesome gem
- Support for callout components (:::info, :::success, :::warning, :::danger, :::neutral)
- Support for details/summary components (^^^...>>>...^^^)
- Support for tab group components (++++++...++++++)
- Automatic Jekyll hooks integration
