# jekyll-webawesome

This is a plugin for [Jekyll](https://jekyllrb.com/) that transforms custom Markdown syntax into [Web Awesome](https://webawesome.com/) components. Use a simple, intuitive Markdown-like syntax to create rich interactive components in your Jekyll website. The goal is to keep HTML out of Markdown files and create an easier experience for non-developers to update content.

The context here is a technical documentation website, and being limited to just basic Markdown features often results in a boring wall of text which the user won't read. The aim is to help create a more visually interesting page to read, by mixing in some components like callouts, tabs, cards and collapsible summary/details.

## Web Awesome components

This plugin focuses on the most commonly used Web Awesome components for Jekyll content. Components are organized by support status:

### Currently supported

| Component | Primary Syntax | Alternative Syntax | HTML Output |
|-----------|----------------|-------------------|-------------|
| **Badge** | `!!!variant` | `:::wa-badge variant` | `<wa-badge variant="brand">content</wa-badge>` |
| **Button** | `%%%variant` | `:::wa-button variant` | `<wa-button variant="brand" href="url">text</wa-button>` or `<wa-button variant="brand">text</wa-button>` |
| **Callouts** | `:::info` | `:::wa-callout info` | `<wa-callout variant="brand"><wa-icon name="circle-info"></wa-icon>content</wa-callout>` |
| **Card** | `===` | `:::wa-card` | `<wa-card>content</wa-card>` |
| **Details** | `^^^` | `:::wa-details` | `<wa-details><summary>summary</summary>content</wa-details>` |
| **Tab Group** | `++++++` | `:::wa-tabs` | `<wa-tab-group><wa-tab>content</wa-tab></wa-tab-group>` |
| **Tag** | `@@@brand` | `:::wa-tag brand` | `<wa-tag variant="brand">content</wa-tag>` |

### Planned

These content-focused components will get dedicated syntax in future releases:

| Component | Primary Syntax | Alternative syntax | HTML Output |
|-----------|----------------------|-------------------|-------------|
| **Copy Button** | `<<<` | `:::wa-copy-button` | `<wa-copy-button>content</wa-copy-button>` |
| **Divider** | `\|\|\|` | `:::wa-divider` | `<wa-divider></wa-divider>` |
| **Icon** | `$$$icon-name` | `:::wa-icon name` | `<wa-icon name="icon-name"></wa-icon>` |
| **Progress Bar** | `&&&value` | `:::wa-progress-bar value` | `<wa-progress-bar value="50"></wa-progress-bar>` |
| **Rating** | `???value` | `:::wa-rating value` | `<wa-rating value="4"></wa-rating>` |
| **Avatar** | (none) | `:::wa-avatar` | `<wa-avatar>` |
| **QR Code** | (none) | `:::wa-qr-code` | `<wa-qr-code>` |
| **Skeleton** | (none) | `:::wa-skeleton` | `<wa-skeleton>` |
| **Spinner** | (none) | `:::wa-spinner` | `<wa-spinner>` |
| **Tooltip** | (none) | `:::wa-tooltip` | `<wa-tooltip>` |

Not all components will make sense to include here, to be included in the "prose" content of a web page. Some components are more suitable to be used in layouts or used in the page as includes, too complicated for this purpose.

Both syntax styles work identically and can be mixed within the same document.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jekyll-webawesome'
```

Add the plugin to your Jekyll site's `_config.yml`:

```yaml
plugins:
  - jekyll-webawesome
```

And add configuration options as needed in `_config.yml`:

```yaml
webawesome:
  # Enable debug output to see which files are being processed
  debug: true
```

And then execute:

```bash
bundle install
```

## Live Examples

See the plugin in action with a complete Jekyll site showcasing all supported components:

```bash
cd examples
bundle install
bundle exec jekyll serve
```

Then visit `http://localhost:4000` to see all components rendered with Web Awesome styling.

> **Note**: All components support dual syntax. You can use either the primary syntax (shown in examples below) or the alternative `:::wa-component` syntax.

## Components

### Callouts

Create callouts using the `:::` syntax:

```markdown
:::info
This is an info callout with **bold text** and [links](https://example.com).
:::

:::success
This is a success callout.
:::

:::warning
This is a warning callout.
:::

:::danger
This is a danger callout.
:::

:::neutral
This is a neutral callout.
:::
```

These transform into Web Awesome callout components with appropriate icons and styling

![Callout component example](readme_screenshots/callouts.png)

### Cards

Create cards using the `===` syntax:

```markdown
===
This is a basic card with just content.
===
```

#### Cards with Headers

The first heading (`#`) automatically becomes the card header:

```markdown
===
# Card Title
This is the card content that appears in the main area.
===
```

#### Cards with Media

The first image automatically becomes the card media:

```markdown
===
![Alt text](image.jpg)
# Featured Content
This card includes both an image and a title.
===
```

#### Cards with Footers

Links at the end of the card content automatically become footer buttons:

```markdown
===
# Get Started
Ready to begin your journey? 
[Learn More](https://example.com)
===
```

#### Complete Cards

You can combine all elements for rich content cards:

```markdown
===filled
![Hero Image](hero.jpg)
# Complete Example
This card has media, header, content, and footer with a filled appearance.
[Get Started](https://example.com)
===
```

#### Card Appearances

You can specify different visual styles:

```markdown
===filled
# Filled Card
This card uses the filled appearance.
===

===plain
# Plain Card
This card uses the plain appearance.
===

===filled-outlined
# Filled Outlined Card
This card uses the filled-outlined appearance.
===

===accent
# Accent Card
This card uses the accent appearance for emphasis.
===
```

### Tags

Create tags using the `@@@` syntax:

```markdown
@@@
Basic tag
@@@

@@@brand
Version 2.0
@@@

@@@success
Completed
@@@

@@@warning
In Progress
@@@

@@@danger
Critical Issue
@@@

@@@neutral
Documentation
@@@
```

These transform into Web Awesome tag components with appropriate colors and styling. Tags support markdown formatting within the content:

```markdown
@@@brand
**v3.0** Beta
@@@

@@@success
[View Results](https://example.com)
@@@
```

### Details/Summary (Collapsible Content)

Create collapsible content using the `^^^` syntax:

```markdown
^^^
Click to expand this summary
>>>
This is the detailed content that can be collapsed and expanded.

You can include:
- Lists
- **Bold text**
- [Links](https://example.com)
- Code blocks
^^^
```

You can also specify appearance styles:

```markdown
^^^filled
Filled appearance summary
>>>
Content goes here
^^^

^^^plain
Plain appearance summary  
>>>
Content goes here
^^^

^^^filled-outlined
Filled and outlined appearance summary
>>>
Content goes here
^^^
```

### Tab Groups

Create tabbed content using the `++++++` syntax:

```markdown
++++++
+++ First Tab
Content for the first tab goes here.
+++

+++ Second Tab
Content for the second tab.
+++

+++ Third Tab
Content for the third tab.
+++
++++++
```

You can specify tab placement:

```markdown
++++++start
+++ Tab 1
Content here
+++
+++ Tab 2  
More content
+++
++++++

++++++bottom
+++ Tab 1
Content here
+++
+++ Tab 2
More content  
+++
++++++
```

Supported placements: `top` (default), `bottom`, `start`, `end`.

## Component Reference

### Callout Types

| Type | Icon | Variant |
|------|------|---------|
| `info` | circle-info | brand |
| `success` | circle-check | success |
| `warning` | triangle-exclamation | warning |
| `danger` | circle-exclamation | danger |
| `neutral` | gear | neutral |

### Card Options

| Type | Description |
|------|-------------|
| `outlined` (default) | Default outlined appearance |
| `filled` | Filled background appearance |
| `plain` | Minimal plain appearance |
| `filled-outlined` | Combination of filled and outlined |
| `accent` | Accent appearance for emphasis |

### Card Structure

Cards automatically parse content into these slots:

- **Media**: First image becomes media slot
- **Header**: First `#` heading becomes header slot  
- **Content**: Remaining content becomes main content
- **Footer**: Trailing links become footer buttons

### Tag Variants

| Type | Description |
|------|-------------|
| (none) | Default neutral appearance |
| `brand` | Primary brand color |
| `success` | Success/positive state |
| `warning` | Warning/caution state |
| `danger` | Error/critical state |
| `neutral` | Neutral/informational state |

### Details Appearances

| Type | CSS Class |
|------|-----------|
| `outlined` (default) | outlined |
| `filled` | filled |
| `plain` | plain |
| `filled-outlined` | filled outlined |

### Tab Placements

- `top` (default)
- `bottom`
- `start`
- `end`

## Requirements

- Jekyll >= 3.7
- Kramdown >= 2.0
- Web Awesome CSS/JS loaded in your site

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/jannewaren/jekyll-webawesome](https://github.com/jannewaren/jekyll-webawesome).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
