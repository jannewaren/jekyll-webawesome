---
layout: default
title: Web Awesome Examples
---

Examples of the Web Awesome components and their markdown syntax.

## Callouts

### Info

#### Live Example

:::info
Content here
:::

#### Syntax

```markdown
:::info
Content here
:::
```

### Success

#### Live Example

:::success
Content here
:::

#### Syntax

```markdown
:::success
Content here
:::
```

### Warning

#### Live Example

:::warning
Content here
:::

#### Syntax

```markdown
:::warning
Content here
:::
```

### Danger

#### Live Example

:::danger
Content here
:::

#### Syntax

```markdown
:::danger
Content here
:::
```

### Neutral

#### Live Example

:::neutral
Content here
:::

#### Syntax

```markdown
:::neutral
Content here
:::
```

### With Bold and Links

#### Live Example

:::info
This is an **important** callout with a [link to Google](https://google.com) and some *italic text*. You can also use `inline code` here.
:::

#### Syntax

```markdown
:::info
This is an **important** callout with a [link to Google](https://google.com) and some *italic text*. You can also use `inline code` here.
:::
```

#### Live Example

:::success
**Success!** Your changes have been saved. Visit [our documentation](https://example.com/docs) for more information.
:::

#### Syntax

```markdown
:::success
**Success!** Your changes have been saved. Visit [our documentation](https://example.com/docs) for more information.
:::
```

### With Complex Content (Lists & Multiple Paragraphs)

#### Live Example

:::info
This is a **complex** callout with multiple features:

- First list item with *italic* text
- Second item with [a link](https://example.com)
- Third item with `inline code`

Here's a second paragraph with more **bold text**.

And a third paragraph to test multiple paragraphs.
:::

#### Syntax

```markdown
:::info
This is a **complex** callout with multiple features:

- First list item with *italic* text
- Second item with [a link](https://example.com)
- Third item with `inline code`

Here's a second paragraph with more **bold text**.

And a third paragraph to test multiple paragraphs.
:::
```

## Tags

### Basic Tags

#### Live Example

@@@
Basic tag
@@@

#### Syntax

```markdown
@@@
Basic tag
@@@
```

### With Variants

#### Live Example

@@@brand
Version 2.0
@@@

#### Syntax

```markdown
@@@brand
Version 2.0
@@@
```

#### Live Example

@@@success
Completed
@@@

#### Syntax

```markdown
@@@success
Completed
@@@
```

#### Live Example

@@@warning
In Progress
@@@

#### Syntax

```markdown
@@@warning
In Progress
@@@
```

#### Live Example

@@@danger
Critical Issue
@@@

#### Syntax

```markdown
@@@danger
Critical Issue
@@@
```

#### Live Example

@@@neutral
Documentation
@@@

#### Syntax

```markdown
@@@neutral
Documentation
@@@
```

### With Markdown Content

#### Live Example

@@@brand
**v3.0** Beta Release
@@@

#### Syntax

```markdown
@@@brand
**v3.0** Beta Release
@@@
```

#### Live Example

@@@success
[View Results](https://example.com)
@@@

#### Syntax

```markdown
@@@success
[View Results](https://example.com)
@@@
```

#### Live Example

@@@warning
*Please review* before continuing
@@@

#### Syntax

```markdown
@@@warning
*Please review* before continuing
@@@
```

## Details

### Basic

#### Live Example

^^^
Summary text
>>>
Details content
^^^

#### Syntax

```markdown
^^^
Summary text
>>>
Details content
^^^
```

### Filled

#### Live Example

^^^filled
Summary with filled style
>>>
Content
^^^

#### Syntax

```markdown
^^^filled
Summary with filled style
>>>
Content
^^^
```

### Plain

#### Live Example

^^^plain
Summary with plain style
>>>
Content
^^^

#### Syntax

```markdown
^^^plain
Summary with plain style
>>>
Content
^^^
```

### Filled + Outlined

#### Live Example

^^^filled-outlined
Summary with both styles
>>>
Content
^^^

#### Syntax

```markdown
^^^filled-outlined
Summary with both styles
>>>
Content
^^^
```

### With Extra Formatting

#### Live Example

^^^
Click here for **important** information
>>>
This details section contains **bold text**, [a link to our docs](https://example.com), and *italic text*. You can also use `inline code` formatting.

- And lists
- With multiple items
^^^

#### Syntax

```markdown
^^^
Click here for **important** information
>>>
This details section contains **bold text**, [a link to our docs](https://example.com), and *italic text*. You can also use `inline code` formatting.

- And lists
- With multiple items
^^^
```

## Tab Groups

### Default (Top)

#### Live Example

++++++
+++ Tab 1
Content for tab 1
+++

+++ Tab 2
Content for tab 2
+++
++++++

#### Syntax

```markdown
++++++
+++ Tab 1
Content for tab 1
+++

+++ Tab 2
Content for tab 2
+++
++++++
```

### Bottom Placement

#### Live Example

++++++bottom
+++ Tab 1
Content with tabs at bottom
+++

+++ Tab 2
More content for tab 2
+++
++++++

#### Syntax

```markdown
++++++bottom
+++ Tab 1
Content with tabs at bottom
+++

+++ Tab 2
More content for tab 2
+++
++++++
```

### Start Placement (Left)

#### Live Example

++++++start
+++ Tab 1
Content with tabs on left
+++

+++ Tab 2
More content for tab 2
+++
++++++

#### Syntax

```markdown
++++++start
+++ Tab 1
Content with tabs on left
+++

+++ Tab 2
More content for tab 2
+++
++++++
```

### End Placement (Right)

#### Live Example

++++++end
+++ Tab 1
Content with tabs on right
+++

+++ Tab 2
More content for tab 2
+++
++++++

#### Syntax

```markdown
++++++end
+++ Tab 1
Content with tabs on right
+++

+++ Tab 2
More content for tab 2
+++
++++++
```

### With Bold and Links in Tabs

#### Live Example

++++++
+++ **Quick Start**
Get started quickly with our [installation guide](https://example.com/install). This tab contains **bold text** and *italic formatting*.
+++

+++ *Advanced* Setup
For advanced users, check out our [advanced configuration docs](https://example.com/advanced). Use `npm install` to get started.
+++
++++++

#### Syntax

```markdown
++++++
+++ **Quick Start**
Get started quickly with our [installation guide](https://example.com/install). This tab contains **bold text** and *italic formatting*.
+++

+++ *Advanced* Setup
For advanced users, check out our [advanced configuration docs](https://example.com/advanced). Use `npm install` to get started.
+++
++++++
```

## Cards

### Basic Card

#### Live Example

===
This is a basic card with just content. It provides a simple container for organizing information.
===

#### Syntax

```markdown
===
This is a basic card with just content. It provides a simple container for organizing information.
===
```

### Card with Header

#### Live Example

===
# Welcome Card
This card has a title that will appear in the header slot, making it easy to identify the content.
===

#### Syntax

```markdown
===
# Welcome Card
This card has a title that will appear in the header slot, making it easy to identify the content.
===
```

### Card with Media and Header

#### Live Example

===
![Example Image](image.png)
# Featured Content
This card includes both an image in the media slot and a title in the header slot.
===

#### Syntax

```markdown
===
![Example Image](image.png)
# Featured Content
This card includes both an image in the media slot and a title in the header slot.
===
```

### Card with Footer Button

#### Live Example

===
# Get Started
Ready to begin your journey? This card includes a call-to-action button in the footer.
[Learn More](https://example.com)
===

#### Syntax

```markdown
===
# Get Started
Ready to begin your journey? This card includes a call-to-action button in the footer.
[Learn More](https://example.com)
===
```

### Complete Card with All Features

#### Live Example

===filled
![Hero Image](image.png)
# Complete Example
This is a complete card example that includes media, header, content, and footer. It uses the filled appearance for a different visual style.
[Get Started](https://example.com)
===

#### Syntax

```markdown
===filled
![Hero Image](image.png)
# Complete Example
This is a complete card example that includes media, header, content, and footer. It uses the filled appearance for a different visual style.
[Get Started](https://example.com)
===
```

### Card Appearances

#### Filled Appearance

##### Live Example

===filled
# Filled Card
This card uses the filled appearance for a more prominent display.
===

##### Syntax

```markdown
===filled
# Filled Card
This card uses the filled appearance for a more prominent display.
===
```

#### Plain Appearance

##### Live Example

===plain
# Plain Card
This card uses the plain appearance for a minimal look.
===

##### Syntax

```markdown
===plain
# Plain Card
This card uses the plain appearance for a minimal look.
===
```

#### Filled Outlined Appearance

##### Live Example

===filled-outlined
# Filled Outlined Card
This card uses the filled-outlined appearance combining both styles.
===

##### Syntax

```markdown
===filled-outlined
# Filled Outlined Card
This card uses the filled-outlined appearance combining both styles.
===
```

#### Accent Appearance

##### Live Example

===accent
# Accent Card
This card uses the accent appearance for emphasis and highlighting.
===

##### Syntax

```markdown
===accent
# Accent Card
This card uses the accent appearance for emphasis and highlighting.
===
```

### Cards with Rich Content

#### Live Example

===
# Project Showcase
This card demonstrates rich content including **bold text**, *italic text*, `inline code`, and [links](https://example.com).

Features include:
- Responsive design
- Accessible markup
- Easy customization
- Modern styling

Perfect for showcasing projects, features, or any structured content.
[View Project](https://github.com/example/project)
===

#### Syntax

```markdown
===
# Project Showcase
This card demonstrates rich content including **bold text**, *italic text*, `inline code`, and [links](https://example.com).

Features include:
- Responsive design
- Accessible markup
- Easy customization
- Modern styling

Perfect for showcasing projects, features, or any structured content.
[View Project](https://github.com/example/project)
===
```

### Code Blocks in Cards

#### Live Example

===
# Installation Guide
Follow these steps to install the package:

```bash
npm install jekyll-webawesome
bundle install
```

Then add it to your `_config.yml`:

```yaml
plugins:
  - jekyll-webawesome
```

[View Documentation](https://github.com/example/docs)
===

#### Syntax

```markdown
===
# Installation Guide
Follow these steps to install the package:

```bash
npm install jekyll-webawesome
bundle install
```

Then add it to your `_config.yml`:

```yaml
plugins:
  - jekyll-webawesome
```

[View Documentation](https://github.com/example/docs)
===
```

## Code Blocks Inside Components

Testing whether code blocks work properly inside Web Awesome components.

### Code Blocks in Callouts

#### Live Example

:::info
Here's a JavaScript example:

```javascript
function greet(name) {
    return `Hello, ${name}!`;
}

console.log(greet('World'));
```

:::

### Code Blocks in Details

#### Live Example

^^^
Click to see Python code
>>>
Here's a Python function:

```python
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)

# Generate first 10 Fibonacci numbers
for i in range(10):
    print(f"fib({i}) = {fibonacci(i)}")
```

^^^

### Code Blocks in Tab Groups

#### Live Example

++++++
+++ JavaScript

```javascript
// Array methods example
const numbers = [1, 2, 3, 4, 5];
const doubled = numbers.map(x => x * 2);
console.log(doubled); // [2, 4, 6, 8, 10]
```

+++

+++ Python

```python
# List comprehension example
numbers = [1, 2, 3, 4, 5]
doubled = [x * 2 for x in numbers]
print(doubled)  # [2, 4, 6, 8, 10]
```

+++

+++ Ruby

```ruby
# Ruby array mapping
numbers = [1, 2, 3, 4, 5]
doubled = numbers.map { |x| x * 2 }
puts doubled  # [2, 4, 6, 8, 10]
```

+++
++++++
