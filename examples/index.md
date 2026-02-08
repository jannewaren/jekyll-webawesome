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

### Combined size and appearance

:::info small accent
Small accent callout — compact and eye-catching.
:::

:::warning large filled-outlined
Large filled-outlined warning callout.
:::

## Tags

Tags can be used in two ways: **block syntax** (with newlines) or **inline syntax** (on the same line with spaces).

### Block Tags

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

### Inline Tags

Use inline tags in headings or within text: @@@ brand v2.0 @@@ or @@@ success New @@@

#### In Headings

### Feature @@@ brand v2.0 @@@ Released

### Status @@@ warning Beta @@@ Features

#### In Text

This release has @@@ success stable @@@ status and includes @@@ brand new features @@@.

You can use multiple variants: @@@ brand Brand @@@ @@@ success Success @@@ @@@ neutral Neutral @@@ @@@ warning Warning @@@ @@@ danger Danger @@@

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

## Tab Groups

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

Alternative syntax with :::wa-copy-button:

:::wa-copy-button
Alternative syntax example
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

