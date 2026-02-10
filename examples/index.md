---
layout: default
title: Web Awesome Examples
---

# Web Awesome Component Examples

This page demonstrates the jekyll-webawesome plugin's custom Markdown syntax for creating Web Awesome components. Each component shows both the syntax and the rendered result.

## Callouts

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

:::brand
This is a brand callout (the official variant name, same as `info`).
:::

### Callouts with size

The `size` attribute affects internal padding and typography. Compare the compact padding of `small` with the generous spacing of `large`:

:::info small
This is a **small** callout with compact padding.
:::

:::info
This is a **medium** callout (default) with standard padding.
:::

:::info large
This is a **large** callout with generous padding.
:::

### Callouts with appearance

The `appearance` attribute controls visual styling. Each appearance has a distinct look:

:::info accent
**Accent** — Bold and prominent with solid color, perfect for important notices.
:::

:::warning outlined
**Outlined** — Subtle with just a border, good for less critical info.
:::

:::success plain
**Plain** — Minimal styling with just text color, most subtle option.
:::

:::danger filled
**Filled** — Solid background without border, strong visual presence.
:::

:::info filled-outlined
**Filled-outlined** (default) — Combines filled background with border for maximum clarity.
:::

### Custom Icons

Override the default variant icon with `icon:name`:

:::warning icon:shield
**Security notice** — uses a shield icon instead of the default warning icon.
:::

:::brand icon:rocket
**Launch update** — custom rocket icon for brand callout.
:::

:::success icon:thumbs-up
**Approved!** — thumbs-up icon overrides the default checkmark.
:::

:::danger icon:skull
**Critical failure** — custom icon for emphasis.
:::

Custom icon with size and appearance:

:::brand icon:lightbulb large filled
**Pro tip** — a large filled callout with a lightbulb icon. Size and appearance work alongside custom icons.
:::

### Combined size and appearance

:::info small accent
Small accent callout — compact and eye-catching.
:::

:::warning large filled-outlined
Large filled-outlined warning callout.
:::

## Tags

Tags can be used in two ways: **block syntax** (with newlines) or **inline syntax** (on the same line with spaces).

### Basic Tag Variants

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

### Appearance Styles

Tags support four different appearance styles:

@@@accent
Accent appearance
@@@

@@@filled
Filled appearance
@@@

@@@outlined
Outlined appearance
@@@

@@@filled-outlined
Filled-outlined (default)
@@@

You can combine variants with appearances:

@@@brand accent
Brand accent
@@@

@@@success filled
Success filled
@@@

@@@warning outlined
Warning outlined
@@@

@@@danger filled-outlined
Danger filled-outlined
@@@

### Sizes

Tags come in three sizes:

@@@small
Small tag
@@@

@@@medium
Medium tag (default)
@@@

@@@large
Large tag
@@@

Combined with variants:

@@@brand small
Small brand
@@@

@@@success medium
Medium success
@@@

@@@danger large
Large danger
@@@

### Pill Shape

The `pill` attribute gives tags rounded edges:

@@@pill
Rounded tag
@@@

@@@brand pill
Brand pill
@@@

@@@success pill large
Large success pill
@@@

@@@warning pill small
Small warning pill
@@@

### Tags with Icons

Add an icon inside a tag with `icon:name`:

@@@success icon:check
Approved
@@@

@@@danger icon:circle-xmark
Rejected
@@@

@@@brand icon:star
Featured
@@@

@@@warning icon:clock
Pending
@@@

Combined with other attributes:

@@@success icon:circle-check large pill
Verified
@@@

@@@danger icon:fire small filled
Hot
@@@

Inline tags with icons: @@@ brand icon:star Featured @@@ and @@@ success icon:check Done @@@ and @@@ warning icon:clock Pending @@@

### Removable Tags

Tags with the `with-remove` attribute show a remove button:

@@@with-remove
Removable tag
@@@

@@@brand with-remove
Removable brand tag
@@@

@@@success large with-remove
Large removable success tag
@@@

@@@danger pill with-remove
Removable pill-shaped danger tag
@@@

### Combined Attributes

All tag attributes work together in any order:

@@@brand accent small pill
Small brand accent pill
@@@

@@@success filled large with-remove
Large filled success with remove
@@@

@@@warning outlined medium pill
Medium outlined warning pill
@@@

@@@danger filled-outlined large pill with-remove
Large danger pill with all features
@@@

@@@pill large filled brand
Same as first (order doesn't matter)
@@@

### Inline Tags

Use inline tags in headings or within text: @@@ brand v2.0 @@@ or @@@ success New @@@

#### In Headings

### Feature @@@ brand v2.0 @@@ Released

### Status @@@ warning Beta @@@ Features

#### In Text

This release has @@@ success stable @@@ status and includes @@@ brand new features @@@.

You can use multiple variants: @@@ brand Brand @@@ @@@ success Success @@@ @@@ neutral Neutral @@@ @@@ warning Warning @@@ @@@ danger Danger @@@

#### Inline with Attributes

Inline tags support all attributes: @@@ pill small brand Tag @@@ and @@@ large filled success Ready @@@ and @@@ pill with-remove danger Remove @@@.

Status @@@ accent small brand Active @@@ - Version @@@ pill large success v2.0 @@@

## Comparison

|||25
![Grayscale image](image.png)
![Color image](image_colours.png)
|||

This shows before/after comparison functionality with initial position at 25%.

## Details/Summary (Collapsible Content)

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

### Icon placement

Defaults to end but you can use start to get the icon at the beginning.

^^^plain start
Plain appearance summary
>>>
The icon is in the beginning now
^^^

### Custom Expand/Collapse Icons

Replace the default toggle icon with custom expand and collapse icons:

^^^icon:expand:plus icon:collapse:minus
Click to expand (plus/minus icons)
>>>
Custom expand/collapse icons make the interaction more intuitive. The plus becomes a minus when opened.
^^^

^^^icon:expand:chevron-down icon:collapse:chevron-up filled
Chevron icons with filled appearance
>>>
Chevron-down when collapsed, chevron-up when expanded. Combined with filled appearance.
^^^

^^^icon:expand:caret-right icon:collapse:caret-down open
Caret icons (open by default)
>>>
This uses right/down caret icons and starts expanded.
^^^

### Disabled State

The `disabled` attribute prevents the details from expanding:

^^^disabled
This summary cannot be expanded
>>>
This content is locked and cannot be viewed (you can't see this!)
^^^

^^^filled disabled
Filled but disabled
>>>
This content is also locked
^^^

### Open by Default

The `open` attribute makes the details initially expanded:

^^^open
This details is open by default
>>>
You can see this content immediately when the page loads. Click the summary to collapse it.
^^^

^^^filled-outlined open
Open with styled appearance
>>>
This one is also initially expanded with custom styling.
^^^

### Accordion Behavior (Grouping)

Use `name:group-id` to create accordion behavior where only one can be open at a time:

^^^name:accordion-demo open
First Section (initially open)
>>>
This section starts open. When you click another section below, this one will automatically close.
^^^

^^^name:accordion-demo
Second Section
>>>
Click this summary to open this section. The first section will automatically close.
^^^

^^^name:accordion-demo
Third Section
>>>
Opening this section will close whichever section is currently open.
^^^

### Combining Multiple Attributes

All attributes can be combined in any order:

^^^filled start open name:styled-accordion
First Styled Section
>>>
This has custom appearance, icon position, starts open, and is part of an accordion group.
^^^

^^^filled start name:styled-accordion
Second Styled Section
>>>
Same styling and grouping. Opening this closes the first section.
^^^

## Tab Groups

### Basic Tab Group

Default placement at top:

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

### Tab Placement

Tabs on the left side (start):

++++++start
+++ Tab 1
Content here with start placement
+++
+++ Tab 2
More content
+++
++++++

Tabs on the bottom:

++++++bottom
+++ Tab 1
Content here with bottom placement
+++
+++ Tab 2
More content
+++
++++++

Tabs on the right side (end):

++++++end
+++ Tab 1
Content here with end placement
+++
+++ Tab 2
More content
+++
++++++

### Initial Active Tab

Set which tab is active on load (second tab is active here):

++++++tab-2
+++ First Tab
This is not active initially
+++
+++ Second Tab
This tab is active on load!
+++
+++ Third Tab
This is not active initially
+++
++++++

### Keyboard Navigation

Manual activation requires Space/Enter after arrow key navigation:

++++++manual
+++ General
Use arrow keys to focus, then press Space or Enter to activate.
+++
+++ Advanced
Try navigating with arrow keys!
+++
+++ Settings
Manual activation prevents accidental tab switches.
+++
++++++

Auto activation (default behavior) switches immediately:

++++++auto
+++ Tab 1
Arrow keys switch tabs immediately.
+++
+++ Tab 2
No need to press Space or Enter.
+++
++++++

### Scroll Controls

Disable scroll arrows for many tabs:

++++++no-scroll-controls
+++ Tab 1
No scroll arrows displayed
+++
+++ Tab 2
Content 2
+++
+++ Tab 3
Content 3
+++
+++ Tab 4
Content 4
+++
+++ Tab 5
Content 5
+++
++++++

### Combining Attributes

All attributes work together in any order:

++++++bottom manual tab-3
+++ First Tab
Not initially active
+++
+++ Second Tab
Also not active
+++
+++ Third Tab
This tab is active on load, tabs are at bottom, and keyboard navigation is manual!
+++
++++++

Complex combination with all features:

++++++end manual tab-2 no-scroll-controls
+++ General
Basic settings
+++
+++ Advanced
This tab is active initially. Tabs are on the right, keyboard navigation is manual, and scroll controls are disabled.
+++
+++ Pro
Professional settings
+++
++++++

### Alternative Syntax

Using explicit `:::wa-tab-group` syntax:

:::wa-tab-group start manual
+++ General
This uses the alternative syntax with start placement and manual activation.
+++
+++ Custom
Alternative syntax works the same way!
+++
:::

All attributes work with alternative syntax:

:::wa-tab-group bottom tab-2 no-scroll-controls
+++ First
Not active
+++
+++ Second
Active on load using alternative syntax
+++
+++ Third
Also not active
+++
:::

## Badges

!!!
New
!!!

!!!brand
5
!!!

!!!success
Online
!!!

!!!warning
3 pending
!!!

!!!danger
Error
!!!

!!!neutral
Draft
!!!

## Buttons

### Basic Button Variants

Link buttons with different variants:

%%%brand
[Go to Google](https://www.google.com)
%%%

%%%success
[Get Started](https://example.com/start)
%%%

%%%warning
[Proceed with Caution](https://example.com/warning)
%%%

%%%danger
[Delete Account](https://example.com/delete)
%%%

%%%neutral
[Learn More](https://example.com/docs)
%%%

Regular buttons (non-link):

%%%brand
Submit Form
%%%

%%%danger
Reset Data
%%%

### Buttons with Icons

Add icons to buttons with `icon:name` (start slot by default) or `icon:end:name`:

%%%brand icon:download
Download File
%%%

%%%success icon:check
Confirm
%%%

%%%danger icon:trash
Delete Item
%%%

Button with end icon:

%%%icon:end:arrow-right
Next Step
%%%

Button with both start and end icons:

%%%brand icon:start:gear icon:end:arrow-right
Settings
%%%

Icons with other attributes:

%%%success icon:download large pill
[Download Now](https://example.com/download)
%%%

%%%warning icon:triangle-exclamation small outlined
Caution
%%%

%%%brand icon:rocket filled
[Launch App](https://example.com/launch)
%%%

### Button Appearances

Buttons with different appearance styles (using brand variant):

%%%brand accent
Accent (Default)
%%%

%%%brand filled
Filled Appearance
%%%

%%%brand outlined
Outlined Appearance
%%%

%%%brand filled-outlined
Filled-Outlined
%%%

%%%brand plain
Plain Appearance
%%%

### Button Sizes

Buttons in different sizes:

%%%small
Small Button
%%%

%%%medium
Medium Button (Default)
%%%

%%%large
Large Button
%%%

Size combined with variant:

%%%brand small
Small Brand
%%%

%%%success large
Large Success
%%%

### Pill Buttons

Pill buttons have rounded edges:

%%%pill
Rounded Button
%%%

%%%brand pill
Brand Pill
%%%

%%%success pill large
Large Success Pill
%%%

%%%danger pill small
Small Danger Pill
%%%

Pill link buttons:

%%%pill brand
[Download](https://example.com/download)
%%%

### Buttons with Caret

Buttons with dropdown indicator:

%%%caret
Options ▼
%%%

%%%brand caret
Actions ▼
%%%

%%%success caret small
Small Menu
%%%

### Button States

Loading state:

%%%loading
Processing...
%%%

%%%brand loading
Saving Changes...
%%%

Disabled state:

%%%disabled
Can't Click
%%%

%%%danger disabled
Cannot Delete
%%%

%%%brand disabled
[Disabled Link](https://example.com)
%%%

### Complex Combinations

Multiple attributes combined:

%%%brand filled large pill
Large Filled Pill
%%%

%%%success outlined small pill caret
Small Options
%%%

%%%warning filled medium
Medium Warning
%%%

%%%danger outlined large pill
Large Danger Pill
%%%

Link button with all attributes:

%%%brand filled large pill
[Download Now](https://example.com/download)
%%%

%%%success outlined small
[Get Started](https://example.com/start)
%%%

### Alternative Syntax

Using :::wa-button syntax:

:::wa-button brand
Regular Button
:::

:::wa-button success filled large
Large Filled Success
:::

:::wa-button danger pill
[Link Button](https://example.com)
:::

## Copy Buttons

Basic copy buttons:

<<<
Copy this simple text
<<<

Copy buttons with markdown formatting:

<<<
**Copy** this text with *markdown* formatting and `code`
<<<

Multiline copy button examples:

<<<
This is a multiline
copy button example
with multiple lines of text
<<<

### Tooltip Placement

Control where the tooltip appears relative to the button:

<<<top
Tooltip appears on top (default)
<<<

<<<right
Tooltip appears on the right
<<<

<<<bottom
Tooltip appears on the bottom
<<<

<<<left
Tooltip appears on the left
<<<

### Custom Labels

Customize the tooltip messages for different states:

<<<copy-label="Click to copy"
Custom copy label only
<<<

<<<copy-label="Copy to clipboard" success-label="Copied successfully!"
Custom copy and success labels
<<<

<<<copy-label="Copy" success-label="Done!" error-label="Copy failed"
All three labels customized
<<<

### Feedback Duration

Control how long the success message is displayed (in milliseconds):

<<<250
Quick feedback (250ms)
<<<

<<<2000
Long feedback (2 seconds)
<<<

<<<3000 right
3 second feedback with right tooltip
<<<

### Disabled State

Disabled copy buttons cannot be clicked:

<<<disabled
You cannot copy this
<<<

<<<disabled bottom
Disabled with bottom tooltip
<<<

<<<disabled top 1500
Disabled with custom duration and placement
<<<

### Copy from Another Element

Copy content from other elements by ID (requires the element to exist on the page):

<span id="example-text">This text can be copied</span>

<<<from="example-text"
Copy from span above
<<<

<input type="text" id="example-input" value="Input value to copy" style="margin-bottom: 1rem;">

<<<from="example-input.value" right
Copy from input's value property
<<<

<a id="example-link" href="https://webawesome.com">Web Awesome</a>

<<<from="example-link[href]" bottom
Copy link's href attribute
<<<

### Combined Attributes

Mix and match attributes in any order:

<<<right 1500 copy-label="Click to copy"
Right tooltip, 1.5s feedback, custom label
<<<

<<<bottom disabled copy-label="Cannot copy" error-label="Copying disabled"
Disabled with custom messages
<<<

<<<left 2000 copy-label="Copy this" success-label="Copied!" error-label="Failed to copy"
Full customization: placement, duration, all labels
<<<

<<<top 500 copy-label="Quick copy" success-label="Done"
Fast feedback with custom labels
<<<

### Alternative Syntax

The `:::wa-copy-button` syntax works identically:

:::wa-copy-button
Alternative syntax example
:::

:::wa-copy-button right
Alternative syntax with right tooltip
:::

:::wa-copy-button disabled bottom 2000
Alternative syntax with multiple attributes
:::

:::wa-copy-button copy-label="Copy code" success-label="Code copied!"
npm install jekyll-webawesome
:::

## Dialogs

### Manual Dialogs

Basic dialog:

???
Open Basic Dialog
>>>
This is a simple dialog with **markdown** support and [links](https://example.com).
???

Dialog with heading as label:

???
Show Information
>>>
# Important Notice
Please read this information carefully before proceeding.
???

Dialog with light dismiss (click outside to close):

???light-dismiss
Open Light Dismiss Dialog
>>>
# Click Outside
You can close this dialog by clicking on the overlay.
???

Dialog with custom width (600px):

???600px
Open Wide Dialog
>>>
# Custom Width
This dialog is 600 pixels wide.
???

Dialog with custom width (50vw):

???50vw
Open Half-Screen Dialog
>>>
# Viewport Width
This dialog is 50% of the viewport width.
???

Dialog with all options combined:

???light-dismiss 700px
Open Custom Dialog
>>>
# Fully Customized
This dialog has light dismiss enabled and is 700px wide. It includes:

- **Markdown formatting**
- Lists and structured content
- [External links](https://webawesome.com)
- Code: `console.log('Hello')`

Click outside or use the close button below!
???

Alternative syntax:

:::wa-dialog
Alternative Dialog Syntax
>>>
# Alternative Syntax
This uses the `:::wa-dialog` syntax instead of `???`.
:::

:::wa-dialog light-dismiss 45em
Alternative with Options
>>>
This combines alternative syntax with light-dismiss and 45em width.
:::

### Image Dialogs (Auto-transformed Images)

**Note:** Enable this feature in `_config.yml`:
```yaml
webawesome:
  image_dialog: true
```

When enabled, all images automatically become clickable and open in a full-size dialog:

![BW Image](image.png)

![Colour Image](image_colours.png)

You can control the dialog width by adding a width parameter in the title:

![BW Image with custom width](image.png "50%")

![Colour Image in large dialog](image_colours.png "800px")

![Full viewport width](image.png "90vw")

Same with a big image

![Big Image with custom width](image_big.png "50%")

![Big Image in large dialog](image_big.png "800px")

![Full viewport width](image_big.png "90vw")

You can also control thumbnail display width with inline HTML:

<img src="image.png" alt="Small thumbnail" width="200" />

<img src="image_colours.png" alt="Medium size" style="width: 50%;" />

To prevent an image from being transformed, add `"nodialog"` to the title attribute:

![Icon image](image.png "nodialog")

Images in inline code are automatically protected: `![example](image.png)` won't be transformed.

## Cards

===
This is a basic card with just content.
===

===
# Card Title
This is the card content that appears in the main area.
===

===
![Alt text](image.png)
# Featured Content
This card includes both an image and a title.
===

===
# Get Started
Ready to begin your journey? 
[Learn More](https://example.com)
===

===filled
![Hero Image](image.png)
# Complete Example
This card has media, header, content, and footer with a filled appearance.
[Get Started](https://example.com)
===

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

### Card Orientations

Horizontal layout displays media and content side-by-side:

===horizontal
![Feature Image](image.png)
# Horizontal Card
This card displays with a side-by-side layout where media appears on the left and content on the right. Perfect for showcasing features or products.
===

===filled horizontal
![Product Photo](image_colours.png)
# Filled Horizontal
Combine appearance and orientation attributes for varied styling. The filled appearance with horizontal layout creates a bold presentation.
===

===accent horizontal
![Accent Feature](image_big.png)
# Accent Horizontal
The accent appearance combined with horizontal orientation draws attention to important content while maintaining a modern side-by-side layout.
===

===plain horizontal
![Simple Layout](image.png)
# Plain Horizontal
The plain appearance with horizontal orientation creates a clean, minimal presentation ideal for simple content displays.
===

## Carousel

### Basic Carousel

~~~~~~
~~~
![Mountain landscape](image.png)

**Mountain Beauty**

Breathtaking views of mountain peaks
~~~
~~~
![Ocean scene](image_colours.png)

**Ocean Waves**

Peaceful coastal scenery
~~~
~~~
![Forest path](image_big.png)

**Forest Trail**

Walk through nature
~~~
~~~~~~

### Multiple Slides Per View

Show 3 slides at once:

~~~~~~3
~~~
**Slide 1**

First product description
~~~
~~~
**Slide 2**

Second product description
~~~
~~~
**Slide 3**

Third product description
~~~
~~~
**Slide 4**

Fourth product description
~~~
~~~
**Slide 5**

Fifth product description
~~~
~~~~~~

### With Navigation and Pagination

~~~~~~navigation pagination
~~~
**Slide One**

Content for the first slide with navigation
~~~
~~~
**Slide Two**

Content for the second slide
~~~
~~~
**Slide Three**

Content for the third slide
~~~
~~~~~~

### Looping Carousel

Continuously loop through slides:

~~~~~~loop navigation pagination
~~~
**Product A**

Description of product A
~~~
~~~
**Product B**

Description of product B
~~~
~~~
**Product C**

Description of product C
~~~
~~~~~~

### Autoplay Carousel

Automatically advance slides every 5 seconds:

~~~~~~autoplay autoplay-interval:5000 loop pagination
~~~
**Auto Slide 1**

This carousel auto-advances every 5 seconds
~~~
~~~
**Auto Slide 2**

Watch it transition automatically
~~~
~~~
**Auto Slide 3**

Autoplay pauses during user interaction
~~~
~~~~~~

> **Note**: Autoplay interval is specified in milliseconds (5000 = 5 seconds). The default is 3000ms (3 seconds) if not specified. Autoplay automatically pauses when users interact with the carousel.

### With Scroll Hint

Show adjacent slides peeking:

~~~~~~scroll-hint:2rem navigation
~~~
![Product 1](image.png)

**Product One**
~~~
~~~
![Product 2](image_colours.png)

**Product Two**
~~~
~~~
![Product 3](image_big.png)

**Product Three**
~~~
~~~~~~

### Advanced: Multiple Slides, Custom Move

Show 3 slides, move 2 at a time:

~~~~~~3 2 loop navigation pagination
~~~
**Feature 1**

Description here
~~~
~~~
**Feature 2**

More details
~~~
~~~
**Feature 3**

Additional info
~~~
~~~
**Feature 4**

Extra content
~~~
~~~
**Feature 5**

Final item
~~~
~~~
**Feature 6**

Bonus item
~~~
~~~~~~

### Vertical Carousel

~~~~~~vertical pagination
~~~
**Top Item**

First item in vertical layout
~~~
~~~
**Middle Item**

Second item
~~~
~~~
**Bottom Item**

Third item
~~~
~~~~~~

### Alternative Syntax

:::wa-carousel navigation pagination
~~~
**Alternative Syntax**

First slide using alternative syntax
~~~
~~~
**Second Slide**

More content here
~~~
:::

## Layouts

Layout containers use `::::` (quadruple colon) syntax to wrap content in Web Awesome CSS layout utilities. Layouts compose with component syntax — use `:::` components inside `::::` layouts.

### Grid — Responsive Card Layout

Cards automatically arrange into a responsive grid:

::::grid gap:l
===
# Getting Started
Set up your project in minutes with our quick-start guide.
[Read Guide](https://example.com)
===

===
# Components
Browse our library of 30+ accessible web components.
[View Docs](https://example.com)
===

===
# Theming
Customize colors, typography, and spacing to match your brand.
[Explore Themes](https://example.com)
===
::::

### Grid with Custom Column Size

Use `min:` to control when columns wrap:

::::grid gap:l min:300px
===filled
# Wide Card One
This grid has a larger minimum column size, so it wraps to fewer columns sooner.
===

===filled
# Wide Card Two
Great for content that needs more horizontal space to breathe.
===

===filled
# Wide Card Three
Resize the browser to see the responsive behavior in action.
===

===filled
# Wide Card Four
Four cards that reflow into 1–3 columns depending on screen width.
===
::::

### Stack — Vertical Spacing

Stack arranges items vertically with consistent spacing. Perfect for sequential content:

::::stack gap:l
:::success
**Step 1** — Install the gem: `gem install jekyll-webawesome`
:::

:::brand
**Step 2** — Add it to your `_config.yml` plugins list.
:::

:::warning
**Step 3** — Use the custom Markdown syntax in your posts and pages.
:::

:::neutral
**Step 4** — Build your site and verify the components render correctly.
:::
::::

### Stack with Tight Spacing

A compact stack with small gap:

::::stack gap:xs
:::success small
Tests passing
:::

:::success small
Build complete
:::

:::brand small
Deployed to production
:::
::::

### Cluster — Inline Elements

Cluster wraps items inline with even spacing. Ideal for tag clouds and status indicators:

::::cluster gap:s
@@@brand pill Version 2.0 @@@

@@@success pill Stable @@@

@@@neutral pill Documentation @@@

@@@warning pill Beta @@@

@@@danger pill Deprecated @@@

@@@brand pill icon:star Featured @@@

@@@success pill icon:check Verified @@@

@@@neutral pill icon:clock Updated @@@
::::

### Cluster with Justify

Center a group of buttons:

::::cluster gap:m justify:center
%%%brand
[Get Started](https://example.com)
%%%

%%%outlined
[Documentation](https://example.com)
%%%

%%%neutral
[GitHub](https://example.com)
%%%
::::

### Split — Two-Column Layout

Split distributes items evenly across the available space:

::::split gap:l
:::brand
**Left Column** — This content sits on the left side of the split. Splits are perfect for navigation bars, headers, and any two-column layout.
:::

:::success
**Right Column** — This content sits on the right side. When the screen gets too narrow, the items will stack vertically.
:::
::::

### Flank — Sidebar Layout

Flank positions one item alongside content that fills the remaining space:

::::flank gap:l size:250px
:::neutral
**Sidebar**

- [Home](#)
- [About](#)
- [Components](#)
- [Layouts](#)
- [Contact](#)
:::

:::brand
**Main Content Area** — The flank layout is perfect for sidebar navigation patterns. The sidebar has a fixed target width (250px here) while the main content stretches to fill the remaining space. When the screen is too narrow, the sidebar wraps below.
:::
::::

### Frame — Constrained Aspect Ratios

Frame creates containers with consistent proportions. Great for images:

::::frame landscape radius:l
<img src="image_colours.png" alt="Landscape framed image">
::::

::::frame portrait radius:m
<img src="image.png" alt="Portrait framed image">
::::

::::frame square radius:circle
<img src="image_colours.png" alt="Square framed image">
::::

### Nested Layouts

Combine layouts by using HTML for the outer container and `::::` syntax for inner layouts. Here's a grid of stacks:

<div class="wa-grid wa-gap-l" style="--min-column-size: 250px">

::::stack gap:s
<h4>$$$rocket Features</h4>

:::brand small accent
Built-in accessibility for all components.
:::

:::brand small accent
Dark mode and theming support.
:::

:::brand small accent
Lightweight — no heavy frameworks required.
:::
::::

::::stack gap:s
<h4>$$$shield Security</h4>

:::success small accent
XSS protection built in.
:::

:::success small accent
CSP-compatible components.
:::

:::success small accent
Regular security audits.
:::
::::

::::stack gap:s
<h4>$$$gauge-high Performance</h4>

:::warning small accent
Lazy-loaded components.
:::

:::warning small accent
Tree-shakeable imports.
:::

:::warning small accent
Under 10kb gzipped core.
:::
::::

</div>

### Alternative Syntax

All layouts support `::::wa-` prefix syntax:

::::wa-stack gap:m
:::info
This layout uses `::::wa-stack` instead of `::::stack`.
:::

:::info
Both syntaxes produce identical output.
:::
::::

