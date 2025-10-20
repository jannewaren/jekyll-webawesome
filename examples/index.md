---
layout: default
title: Web Awesome Examples
---

Examples of the Web Awesome components and their markdown syntax.

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

## Tags

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

%%%brand
Submit Form
%%%

%%%danger
Reset Data
%%%

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

Dialog without header:

???without-header
Open Headerless Dialog
>>>
This dialog has no header bar at the top.
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
