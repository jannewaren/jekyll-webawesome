# Jekyll Web Awesome Plugin Examples

This directory contains a complete Jekyll site that demonstrates all the features of the `jekyll-webawesome` plugin.

## Supported Components

The plugin transforms custom Markdown syntax into the following Web Awesome components:

### 1. Callouts (`wa-callout`)

- Info callouts with blue styling
- Success callouts with green styling  
- Warning callouts with yellow styling
- Danger callouts with red styling
- Neutral callouts with gray styling

### 2. Collapsible Details (`wa-details`)

- Outlined appearance (default)
- Filled appearance
- Plain appearance
- Filled + outlined appearance

### 3. Tab Groups (`wa-tab-group`)

- Top placement (default)
- Bottom placement
- Start placement (left side)
- End placement (right side)

## How to Run the Examples

1. **Install dependencies:**
   ```bash
   cd examples
   bundle install
   ```

2. **Start the Jekyll server:**
   ```bash
   bundle exec jekyll serve
   ```

3. **Open your browser:**
   Navigate to `http://localhost:4000` to see the examples in action

## Taking Screenshots

This example site is perfect for taking screenshots of the plugin in action. The layout is clean and professional, showing each component type with:

- Clear section headers
- Example code syntax
- Live rendered components
- Professional styling

## Files Structure

```
examples/
├── _config.yml          # Jekyll configuration
├── _layouts/
│   └── default.html     # Main layout with Web Awesome CDN
├── _includes/           # (empty, for future includes)
├── index.md            # Main showcase page
├── usage.md            # Original usage examples
├── Gemfile             # Ruby dependencies
└── README.md           # This file
```

## Web Awesome CDN

The examples use the official Web Awesome CDN:

```html
<link rel="stylesheet" href="https://early.webawesome.com/webawesome@3.0.0-beta.4/dist/styles/webawesome.css" />
<script type="module" src="https://early.webawesome.com/webawesome@3.0.0-beta.4/dist/webawesome.loader.js"></script>
```

This ensures all components render correctly with the latest styling and functionality.

## Customization

The `default.html` layout includes custom CSS that:
- Makes the components more visually appealing
- Adds proper spacing and margins
- Creates a professional document appearance
- Highlights the demo sections clearly

You can modify the CSS in the layout file to customize the appearance further.
