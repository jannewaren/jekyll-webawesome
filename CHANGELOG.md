# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)

## [Unreleased]

### Added

- Declarative timestamps, via markawesome's new `DateTransformer`. The inline `[[[ <date> <tokens> ]]]` form renders an absolute, locale-formatted date (`<wa-format-date>`); a leading `relative` token renders a "3 days ago"-style phrase (`<wa-relative-time>`). A block alternative (`:::wa-format-date` / `:::wa-relative-time` … `:::`) is also accepted. The date value is baked into the Markdown at build time; the browser formats it via `Intl.DateTimeFormat` / `Intl.RelativeTimeFormat` with no JavaScript wiring or data fetching — ideal for blog post dates, changelog stamps, and "last updated".
  - `style:`/`time:` presets (`short|medium|long|full`), granular overrides (`weekday`, `month`, `day`, `hour`, … plus `hour-format`, `time-zone-name`, `time-zone`), and `lang:`/`locale:` are supported; a bare date defaults to `style:long`. Relative timestamps take `format:`, `numeric:`, and a `sync` flag for live ticking. Omitting the date renders the viewer's current time.
- Example site's new `## Dates / Timestamps` section exercises the style/time presets, a datetime with `time:` + `hour-format:24`, French/German locales, a granular override, relative times (incl. `format:short` and live `sync`), both block forms, and a no-date "current time" stamp. Validated live in the browser against the examples kit (WA 3.9.0): the components upgrade and render real formatted text in their shadow DOM — e.g. `style:full` → "Friday, June 26, 2026", `lang:fr` → "vendredi 26 juin 2026", `lang:de` → "Freitag, 26. Juni 2026", `hour-format:24` → "Jun 26, 2026, 17:30", relative → "last week" / "4 wk. ago", live `sync` → "44 minutes ago", and a no-date `time:medium` → the current "12:43:56 PM". For reference, a bare `<wa-format-date>` with no format attributes renders WA's terse numeric default ("6/26/2026"), which is why a bare date here defaults to the more readable `style:long`.
  - Like `<wa-icon>`, both components render generated text into shadow DOM with no light-DOM fallback — with Web Awesome's JS disabled they show nothing (the same static-site caveat noted for `<wa-tag with-remove>`).

## [0.22.0] - 2026-06-25

### Added

- Copy-button tooltip mode, via markawesome 0.16.0. A `tooltip:full|copy|none` token on the copy-button line controls *when* the built-in tooltip appears, distinct from the existing `tooltip-placement`: `full` (Web Awesome's default — tooltip on hover/focus plus the brief copy-success/error feedback), `copy` (silent on hover/focus; the tooltip appears only to confirm a copy), and `none` (no tooltip in any state). Combine it with a placement, e.g. `<<<top tooltip:copy`. The token is order-independent with the other copy-button parameters; invalid values are dropped and fall back to Web Awesome's default.
- Example site's `## Copy Buttons` section gains a `### Tooltip Mode` subsection exercising `full`, `copy`, `none`, and a placement combination (`<<<top tooltip:copy`). Validated live in the browser against the examples kit (WA 3.9.0, ≥ 3.6 so `tooltip` is supported): the `tooltip` attribute reflects onto the upgraded `<wa-copy-button>`, and the rendered behavior differs as expected — `full` builds an internal `<wa-tooltip trigger="hover focus">` (opens on hover/focus, shown opening on hover in the live DOM), `copy` builds `<wa-tooltip trigger="manual">` (silent on hover/focus, copy-feedback only), `none` renders no internal tooltip at all (none on hover, confirmed live), and `<<<top tooltip:copy` carries both `tooltip-placement="top"` and `tooltip="copy"`.

### Changed

- Updated `markawesome` dependency to `~> 0.16`.

## [0.21.0] - 2026-06-25

### Added

- Tooltip support, via markawesome 0.15.0. Inline contextual help shown on hover or focus — ideal for glossary terms and inline definitions. The primary form is inline: `(((anchor term >>> tip text)))`. The anchor becomes a focusable, dotted-underlined `<span>` (`tabindex="0"`, class `ma-tooltip-anchor`) and the tip is emitted as a `<wa-tooltip>` wired to it via a generated `for`/`id` pair, so keyboard and assistive-technology users get the tip too. Leading `placement` (`top` default, `bottom`, `left`, `right`) and `distance:N` tokens go before the anchor; tip text is plain text (HTML-escaped) with literal `\n` rendered as `<br>`. A `:::wa-tooltip placement? distance:N? … >>> … :::` block alternative is also accepted. Declarative and zero-JavaScript; no Jekyll-side configuration needed.
- Example site gains a `## Tooltips` section exercising the basic inline form, every placement, `distance:N`, combined parameters, multiple inline tooltips in one sentence, HTML escaping, `\n` line breaks, and the `:::wa-tooltip` alternative form. Validated live in the browser against the examples kit (WA 3.9.0): each anchor's `for` resolves to its tooltip's `id`, the `<wa-tooltip>` upgrades and opens on both hover and focus, and the requested `placement` positions the bubble correctly in the live DOM.

## [0.20.0] - 2026-06-24

### Added

- Accordion support, via markawesome 0.14.0. A multi-section collapsible container — the grouped sibling of Details/Summary, ideal for FAQs and docs sections. The container fence is `//////` (6 slashes) and each item is a `///` block (3 slashes) with an explicit `///` close (or use the `:::wa-accordion … :::` alternative form). Container tokens: `appearance` (`outlined` default, `filled`, `filled-outlined`, `plain`), `mode` (`multiple` default, `single`, `single-collapsible`), `icon-placement` (`start`/`end`), and `heading:N` (`1`–`6` or `none`). Item tokens: leading `expanded`/`disabled` flags, an `icon:name` first child, and the rest of the line as the label. Item bodies are full Markdown and may contain other components.
- Example site gains an `## Accordion` section exercising the basic FAQ shape, every appearance, `single`/`single-collapsible` modes, `icon-placement start`, `heading:2`, an `expanded` item, a `disabled` item, custom item icons, rich item bodies (a nested callout, button, and list), and the `:::wa-accordion` alternative form. Validated live in the browser against the examples kit (rendering, click-to-expand/collapse, `mode="single"` closing the previously open item, and the live-DOM attributes); `wa-accordion` is experimental in Web Awesome but everything used here is declarative and static-safe.

### Changed

- Updated `markawesome` dependency to `~> 0.14`.

## [0.19.0] - 2026-06-20

### Added

- Standalone icons can now be enriched, via markawesome 0.13.0. The `:::wa-icon` block accepts `family`/`variant`/`animation` tokens after the icon name and turns its block body into an accessible `label`, e.g. `:::wa-icon bell shake\n:::` (animates, no Pro kit needed) or `:::wa-icon circle-check solid\nTask complete\n:::` (sets the accessible name). The inline `$$$name` form stays name-only and decorative.
- Callouts can now override their icon's `family`/`variant`/`animation` with bare tokens on the callout line, e.g. `:::warning shake`. The historical `solid` variant default is preserved, so existing callouts are unchanged.
- Example site gains an `## Icons` section (animation, label, variant/family, combined, and an unchanged inline icon) plus an animated-icon callout override. `animation` and `label` are fully functional on the examples kit; `family`/`variant` reach the DOM but only swap the glyph visibly with a Font Awesome Pro kit.

### Changed

- Updated `markawesome` dependency to `~> 0.13`.

## [0.18.0] - 2026-06-19

### Added

- Link-form buttons can now open in a new tab and trigger downloads, via markawesome 0.12.0. Write `target` (`_blank`/`_self`/`_parent`/`_top`) and/or `download` in the button attributes, e.g. `%%%brand _blank\n[Visit](https://example.com)\n%%%` or `%%%neutral download\n[Get file](/files/report.pdf)\n%%%`. A `_blank` target automatically adds `rel="noopener noreferrer"`. These attributes apply only to link-form buttons (markup wrapping a markdown link); on a regular button they are ignored.
- Example site now demonstrates link-button `target`/`download` (open-in-new-tab and download), backed by a small served `downloads/sample.txt` asset.

### Changed

- Updated `markawesome` dependency to `~> 0.12`.

## [0.17.0] - 2026-06-16

### Changed

- Updated `markawesome` dependency to `~> 0.11`, which aligns generated markup with Web Awesome 3.8.0. This fixes four invalid attribute values that previously fell back to wrong defaults (dialog footer button `variant='primary'`, dialog image-trigger and popover trigger `variant='text'`, details `appearance='filled outlined'`) and adds the Web Awesome 3.x size scale (`xs`/`s`/`m`/`l`/`xl`) for buttons, callouts, and tags plus `4xl`/`5xl` layout gap tokens.

### Added

- Example site now demonstrates the Web Awesome 3.x size scale (`xs`–`xl`) for callouts, tags, and buttons, and the `4xl`/`5xl` layout gaps.

## [0.16.0] - 2026-05-05

### Changed

- Internal: code block protection (replacing fenced code blocks with placeholders before Markawesome transforms run, so `:::info`/`^^^`/`@@@` examples inside fenced code stay intact) is now delegated to `Markawesome::CodeBlockProtector` instead of being implemented locally. The Jekyll-specific `{% highlight %}` substitution at priority 15 stays in this gem. No behavior change for Jekyll users.
- Updated `markawesome` dependency to `~> 0.10`. The 0.10.0 release adds `Markawesome::PlainMarkdownRenderer` (an alternate renderer that emits clean GFM instead of HTML) and exposes `Markawesome::CodeBlockProtector` as a public helper.

## [0.15.0] - 2026-03-12

### Added

- **Inline popover syntax** via markawesome 0.9.0: `&&&trigger text >>> popover content&&&` for use within sentences
  - Always renders as link-styled trigger (underlined text)
  - Supports all parameters: placement, `without-arrow`, `distance:N`
  - Plain text content (HTML-escaped, no markdown processing)
  - Multiple inline popovers supported on the same line
- Inline popover examples added to example site
- Updated README with inline popover documentation

### Changed

- Updated `markawesome` dependency to `~> 0.9`

## [0.14.0] - 2026-03-12

### Changed

- Updated `markawesome` dependency to `~> 0.7`
- Popover rich content examples added to example site

## [0.13.0] - 2026-03-12

### Added

- **Popover component** (`&&&` or `:::wa-popover`) via markawesome 0.7.0:
  - Floating popover content attached to a trigger element
  - Placement options: `top` (default), `bottom`, `left`, `right`
  - `without-arrow` flag, `distance:N` parameter, `link` trigger style
  - Trigger text and popover content separated by `>>>`
- Example site updated with popover demonstrations (placements, link style, combined parameters)
- Example site README updated to reference Web Awesome Kit (replaces outdated beta CDN reference)

## [0.12.0] - 2026-02-14

### Changed

- **BREAKING: Card header syntax** — Card headers now use `**bold text**` instead of `# heading` via markawesome 0.6.0. The first bold-only line inside a card block becomes the header slot. This avoids markdownlint warnings (MD025, MD001) and better reflects that card titles are not semantic document headings.
- Updated `markawesome` dependency to `~> 0.6`
- Example site updated with new card header syntax

## [0.11.0] - 2026-02-10

### Added

- Icon component and layout utilities table added to README

## [0.10.0] - 2026-02-10

### Added

- **Layout syntax** via markawesome 0.5.0: new `::::` (quadruple colon) syntax for CSS layout containers
  - `::::grid` — responsive auto-wrapping grid with `min:` column size control
  - `::::stack` — vertical spacing with gap control
  - `::::cluster` — inline wrapping elements (tag clouds, button groups)
  - `::::split` — even two-column/row distribution with `row`/`column` modifiers
  - `::::flank` — sidebar + main content with `size:` and `content:` controls
  - `::::frame` — aspect ratio containers (`landscape`/`portrait`/`square`) with `radius:`
  - Common attributes: `gap:SIZE`, `align:VALUE`, `justify:VALUE`
  - Alternative `::::wa-*` syntax supported for all layout types
  - Nest components (`:::`) inside layouts (`::::`) for page composition
- Example site updated with comprehensive layout demonstrations

### Changed

- Updated `markawesome` dependency to `~> 0.5`

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
