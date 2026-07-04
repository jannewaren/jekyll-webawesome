#!/usr/bin/env node
// build-dataset.mjs — bootstrap generator for examples/_data/examples.yaml
//
// One-off tool that expands markawesome-vscode's component catalogue
// (src/data/components.json) into a comprehensive, per-variant set of
// side-by-side examples. Emits a single examples.yaml that is copied
// byte-for-byte into both jekyll-webawesome and eleventy-plugin-webawesome so
// the two demo sites stay in lockstep. The committed YAML is the source of
// truth thereafter; re-run this only to regenerate from scratch.
//
// Usage: node build-dataset.mjs <path-to-components.json> <output.yaml>

import fs from 'node:fs';

const [, , componentsPath, outPath] = process.argv;
if (!componentsPath || !outPath) {
  console.error('Usage: node build-dataset.mjs <components.json> <output.yaml>');
  process.exit(1);
}

const catalogue = JSON.parse(fs.readFileSync(componentsPath, 'utf8'));
const byName = Object.fromEntries(catalogue.components.map((c) => [c.name, c]));

// --- authoring helpers -----------------------------------------------------

/** A paired example: raw markawesome `code`, with an optional markdown `description`. */
const ex = (title, code, description) => ({ title, description, code: code.trim() + '\n' });
/** A sub-heading that groups the examples that follow it on a category page. */
const heading = (text) => ({ heading: text });

/**
 * A comprehensive icon reference gallery: a responsive grid of plain cards, one
 * per token value — a live icon above its token name. Pure markawesome, and it
 * renders byte-identically in both engines. `items` is `{name, token, caption}`.
 */
const iconGallery = (min, items) =>
  `::::grid gap:s min:${min}\n` +
  items
    .map(
      ({ name, token, caption }) =>
        `===plain\n:::wa-icon ${name}${token ? ` ${token}` : ''}\n:::\n\n${caption}\n===`,
    )
    .join('\n') +
  '\n::::';

// Full enumerations seeded from markawesome-vscode components.json.
const ICON_FAMILIES = byName['Icon'].families; // 25 families, WA 3.10.0
const ICON_VARIANTS = byName['Icon'].variants; // thin…semibold
// Distinctive icon per animation so the motion reads clearly in the preview.
const ICON_ANIMATIONS = [
  ['beat', 'heart'],
  ['fade', 'triangle-exclamation'],
  ['beat-fade', 'circle-exclamation'],
  ['bounce', 'volleyball'],
  ['flip', 'compact-disc'],
  ['flip-360', 'compact-disc'],
  ['shake', 'bell'],
  ['spin', 'arrows-rotate'],
  ['spin-pulse', 'spinner'],
  ['spin-reverse', 'gear'],
  ['spin-snap', 'gear'],
  ['spin-snap-4', 'gear'],
  ['spin-snap-8', 'gear'],
  ['buzz', 'mobile'],
  ['float', 'feather'],
  ['jello', 'cube'],
  ['swing', 'bell'],
  ['wag', 'hand-pointer'],
];

// Canvas changes the *box* around a glyph, not the glyph itself, so each mode is
// shown as a strip of different-width icons in a tinted, dashed box (the CSS
// targets `wa-icon[canvas]`) to make the reserved spacing visible — mirroring
// the old examples page's canvas reference.
const CANVAS_DEMO_ICONS = ['ruler-horizontal', 'image', 'face-smile', 'file', 'ruler-vertical'];
const CANVAS_MODES = [
  ['fixed', '1.25 × 1em', 'same box for every glyph — aligns icons in lists & menus'],
  ['auto', 'auto × 1em', 'each glyph keeps its natural width (ruler-horizontal wide, ruler-vertical narrow)'],
  ['square', '1.25 × 1.25em', 'a uniform square footprint for standalone icons'],
  ['roomy', '1.5 × 1.5em', 'a larger uniform box for standalone icons that need breathing room'],
];
const canvasGallery = () =>
  '::::stack gap:m\n' +
  CANVAS_MODES.map(
    ([mode, dims, desc]) =>
      '===plain\n**' +
      mode +
      '** · `' +
      dims +
      '` — ' +
      desc +
      '\n\n' +
      CANVAS_DEMO_ICONS.map((n) => ':::wa-icon ' + n + ' ' + mode + '\n:::').join('\n') +
      '\n===',
  ).join('\n') +
  '\n::::';

// --- the dataset -----------------------------------------------------------

const categories = [];

// 1. Callouts & status ------------------------------------------------------
categories.push({
  id: 'callouts',
  title: 'Callouts & status',
  intro:
    'Callouts draw attention to important information; badges and tags label and count. ' +
    'Every example shows the exact markawesome markdown on the left and the live Web Awesome ' +
    'component on the right.',
  examples: [
    heading('Callout'),
    ...['info', 'brand', 'success', 'warning', 'danger', 'neutral'].map((t) =>
      ex(
        `Type: ${t}`,
        `:::${t}\nThe **${t}** type, with a [link](https://webawesome.com).\n:::`,
        t === 'info' ? 'The `:::info` type is an alias for `:::brand`.' : undefined,
      ),
    ),
    ...['xs', 's', 'm', 'l', 'xl'].map((s) =>
      ex(`Size: ${s}`, `:::info ${s}\nThe \`${s}\` size drives padding and type scale.\n:::`),
    ),
    ...['accent', 'filled', 'outlined', 'plain', 'filled-outlined'].map((a) =>
      ex(`Appearance: ${a}`, `:::brand ${a}\nAppearance \`${a}\`.\n:::`),
    ),
    ex('Animated icon: shake', ':::warning shake\nThis warning\'s icon animates on a loop.\n:::', 'Append an animation token (`shake`, `spin`, `beat`, `bounce`, …) to animate the icon — no Pro kit needed.'),
    ex('Animated icon: spin', ':::danger spin\nSomething is in progress.\n:::'),
    ex('Custom icon', ':::info icon:rocket\nOverride the default icon with `icon:name`.\n:::'),

    heading('Badge'),
    ...['brand', 'success', 'neutral', 'warning', 'danger'].map((v) =>
      ex(`Variant: ${v}`, `!!!${v}\n${v[0].toUpperCase() + v.slice(1)}\n!!!`),
    ),
    ...['accent', 'filled', 'outlined', 'filled-outlined'].map((a) =>
      ex(`Appearance: ${a}`, `!!!brand ${a}\n${a}\n!!!`),
    ),
    ex('Attention: pulse', '!!!danger pulse\n9\n!!!', 'The `pulse` and `bounce` attention flags animate the badge to draw the eye.'),
    ex('Attention: bounce', '!!!success bounce\nNew\n!!!'),
    ex('Pill', '!!!brand pill\nPill\n!!!'),

    heading('Tag'),
    ...['brand', 'success', 'neutral', 'warning', 'danger'].map((v) =>
      ex(`Variant: ${v}`, `@@@${v}\n${v}\n@@@`),
    ),
    ...['accent', 'filled', 'outlined', 'filled-outlined'].map((a) =>
      ex(`Appearance: ${a}`, `@@@success ${a}\n${a}\n@@@`),
    ),
    ...['xs', 's', 'm', 'l', 'xl'].map((s) => ex(`Size: ${s}`, `@@@neutral ${s}\n${s}\n@@@`)),
    ex('Pill', '@@@brand pill\nPill tag\n@@@'),
    ex('With remove button', '@@@warning with-remove\nDismissible\n@@@'),
    ex('With icon', '@@@success icon:check\nApproved\n@@@'),
  ],
});

// 2. Buttons & actions ------------------------------------------------------
categories.push({
  id: 'buttons',
  title: 'Buttons & actions',
  intro: 'Buttons trigger actions or link out; copy buttons put text on the clipboard in one click.',
  examples: [
    heading('Button'),
    ...['brand', 'success', 'neutral', 'warning', 'danger'].map((v) =>
      ex(`Variant: ${v}`, `%%%${v}\n${v[0].toUpperCase() + v.slice(1)}\n%%%`),
    ),
    ...['accent', 'filled', 'outlined', 'filled-outlined', 'plain'].map((a) =>
      ex(`Appearance: ${a}`, `%%%brand ${a}\n${a}\n%%%`),
    ),
    ...['xs', 's', 'm', 'l', 'xl'].map((s) => ex(`Size: ${s}`, `%%%neutral ${s}\nSize ${s}\n%%%`)),
    ex('Pill', '%%%brand pill\nPill button\n%%%'),
    ex('Caret', '%%%neutral caret\nMenu\n%%%'),
    ex('Loading', '%%%brand loading\nSaving…\n%%%'),
    ex('Disabled', '%%%neutral disabled\nUnavailable\n%%%'),
    ex('Start + end icons', '%%%brand icon:start:gear icon:end:arrow-right\nSettings\n%%%', 'Use `icon:name` (or `icon:start:name`) and `icon:end:name` to place icons on either side of the label.'),
    ex('Link button', '%%%brand icon:download\n[Download the kit](https://example.com/file.zip)\n%%%', 'A markdown link inside the button turns it into an `<a>`; plain text makes a non-link `<button>`.'),

    heading('Copy button'),
    ex('Basic', '<<<\nnpm install markawesome\n<<<', 'Click the icon to copy the text to the clipboard.'),
    ...['top', 'right', 'bottom', 'left'].map((p) =>
      ex(`Tooltip placement: ${p}`, `<<<${p}\ngem install markawesome\n<<<`),
    ),
    ex('Tooltip mode: copy', '<<<tooltip:copy\nyarn add markawesome-js\n<<<', 'Modes: `full` (default), `copy` (feedback only), `none` (no tooltip).'),
    ex('Custom labels', '<<<copy-label="Copy command" success-label="Copied!"\npnpm add markawesome-js\n<<<'),
    ex('Disabled', '<<<disabled\nCannot copy this\n<<<'),
  ],
});

// 3. Cards ------------------------------------------------------------------
categories.push({
  id: 'cards',
  title: 'Cards',
  intro:
    'Cards are flexible containers. The first image becomes the media, the first `#` heading the ' +
    'header, trailing links the footer — everything else is body content.',
  examples: [
    ...['outlined', 'filled', 'filled-outlined', 'plain', 'accent'].map((a) =>
      ex(
        `Appearance: ${a}`,
        `===${a}\n# ${a[0].toUpperCase() + a.slice(1)} card\nA card with the \`${a}\` appearance.\n===`,
      ),
    ),
    ex(
      'Horizontal orientation',
      '===horizontal\n![Feature](../assets/photo.jpg)\n# Horizontal card\nMedia and content sit side-by-side.\n===',
      'Add `horizontal` to place the media beside the content instead of above it.',
    ),
    ex(
      'Media, header, body & footer',
      '===outlined\n![Cover](../assets/photo.jpg)\n# Full card\nA complete card with media, a heading, body copy, and footer actions.\n\n[Learn more](https://webawesome.com) [Dismiss](#)\n===',
      'Trailing markdown links become footer buttons.',
    ),
  ],
});

// 4. Disclosure -------------------------------------------------------------
categories.push({
  id: 'disclosure',
  title: 'Disclosure',
  intro: 'Progressively reveal content: expandable details, grouped accordions, tabs, and trees.',
  examples: [
    heading('Details'),
    ...['outlined', 'filled', 'filled-outlined', 'plain'].map((a) =>
      ex(
        `Appearance: ${a}`,
        `^^^${a}\n${a[0].toUpperCase() + a.slice(1)} summary\n>>>\nHidden body for the \`${a}\` appearance.\n^^^`,
      ),
    ),
    ex('Open by default', '^^^open\nAlready expanded\n>>>\nThis section starts open on load.\n^^^'),
    ex('Icon at start', '^^^start\nSummary with a leading icon\n>>>\nThe expand icon sits before the label.\n^^^'),
    ex('Custom toggle icons', '^^^icon:expand:plus icon:collapse:minus\nClick to expand\n>>>\nCustom plus/minus toggle icons.\n^^^'),

    heading('Accordion'),
    ex(
      'Multiple (default)',
      '//////\n/// What is Web Awesome?\nA library of framework-agnostic web components.\n///\n/// Is it free?\nThe core library is free and open source.\n///\n//////',
      'Several sections can be open at once.',
    ),
    ex(
      'Single',
      '//////filled single\n/// First\nOpening another closes this one.\n///\n/// Second\nOnly one section stays open at a time.\n///\n//////',
    ),
    ex(
      'Single-collapsible',
      '//////outlined single-collapsible\n/// One\nAll sections can be closed.\n///\n/// Two\nOne open at a time — or none.\n///\n//////',
    ),

    heading('Tabs'),
    ...['top', 'bottom', 'start', 'end'].map((p) =>
      ex(
        `Placement: ${p}`,
        `++++++${p}\n+++ Tab one\nContent for the first tab (\`${p}\` placement).\n+++\n+++ Tab two\nContent for the second tab.\n+++\n++++++`,
      ),
    ),
    ex(
      'Manual activation + disabled tab',
      '++++++manual\n+++ Available\nSwitches on click, not hover.\n+++\n+++ disabled Coming soon\nNot yet available.\n+++\n++++++',
    ),

    heading('Tree'),
    ex(
      'File tree',
      '||||||open\n- icon:folder src\n  - icon:file index.ts\n  - icon:file utils.ts\n- icon:file README.md\n||||||',
      'A nested bullet list becomes a `<wa-tree>`. `open` expands the top-level branches.',
    ),
    ex(
      'Collapsed',
      '||||||\n- icon:folder docs\n  - icon:file intro.md\n  - icon:file guide.md\n- icon:folder assets\n  - icon:file logo.svg\n||||||',
    ),
  ],
});

// 5. Overlays ---------------------------------------------------------------
categories.push({
  id: 'overlays',
  title: 'Overlays',
  intro: 'Floating UI attached to a trigger: modal dialogs, popovers, and inline tooltips.',
  examples: [
    heading('Dialog'),
    ex('Basic', '???\nOpen dialog\n>>>\nDialog content with **markdown** support.\n???', 'The text before `>>>` becomes the trigger button; the text after is the dialog body.'),
    ex('Light dismiss', '???light-dismiss\nOpen (click outside to close)\n>>>\nClicking the overlay dismisses this dialog.\n???'),
    ex('Custom width', '???width:400px\nOpen a narrow dialog\n>>>\nThis dialog is 400px wide.\n???'),

    heading('Popover'),
    ...['top', 'bottom', 'left', 'right'].map((p) =>
      ex(
        `Placement: ${p}`,
        `&&&${p}\nHover me (${p})\n>>>\nPopover shown on the \`${p}\` side.\n&&&`,
      ),
    ),
    ex('Link trigger, no arrow', '&&&link without-arrow\nMore info\n>>>\nRendered from a link-styled trigger with no arrow.\n&&&'),
    ex('Inline popover', 'Click &&&here >>> This popover appears inline, mid-sentence.&&& to learn more.', 'The inline form `&&&trigger >>> content&&&` works inside a paragraph.'),

    heading('Tooltip'),
    ex('Inline', 'Styled with (((CSS >>> Cascading Style Sheets))) on the web.', 'The inline form `(((anchor >>> tip)))` underlines the anchor and shows the tip on hover or focus.'),
    ...['top', 'bottom-start', 'right'].map((p) =>
      ex(`Placement: ${p}`, `(((${p} ${p} tip >>> Shown on the ${p} side.)))`),
    ),
    ex('Multi-line tip', '(((Org number >>> NO: 9 digits\\nSE: 10 digits))) varies by country.', 'Use `\\n` inside the tip for line breaks.'),
  ],
});

// 6. Icons & dates ----------------------------------------------------------
categories.push({
  id: 'icons',
  title: 'Icons & dates',
  intro:
    'Standalone icons plus build-time-baked dates. Icons, dates, and relative times render text ' +
    'into shadow DOM, so they need Web Awesome’s runtime to appear.',
  examples: [
    heading('Icon'),
    ex('Inline', 'Open the $$$gear settings panel to continue.', 'Inline `$$$name` drops a decorative icon mid-prose.'),
    ex('Block with label', ':::wa-icon bell\nNotifications\n:::', 'A non-empty block body becomes the icon’s accessible label.'),
    ex(
      'Icon tokens',
      ':::wa-icon star shake solid\n:::',
      'After the name come optional, order-independent `family` / `variant` / `animation` / `canvas` tokens.',
    ),
    ex(
      'Every family',
      iconGallery(
        '120px',
        ICON_FAMILIES.map((f) => ({ name: f === 'brands' ? 'github' : 'star', token: f, caption: f })),
      ),
      'Every Web Awesome 3.10.0 icon family. `classic` and `brands` are free; `duotone` / `sharp` / `sharp-duotone` need Font Awesome Pro; the rest are Pro+ packs — on a free kit they fall back to `classic`, so this doubles as a token reference.',
    ),
    ex(
      'Every variant',
      iconGallery(
        '110px',
        ICON_VARIANTS.map((v) => ({ name: 'star', token: v, caption: v })),
      ),
      'The Font Awesome weight. `regular` and `solid` are free; `thin` / `light` / `semibold` need a Pro kit.',
    ),
    ex(
      'Every animation',
      iconGallery(
        '120px',
        ICON_ANIMATIONS.map(([animation, name]) => ({ name, token: animation, caption: animation })),
      ),
      'Animations are pure CSS, so every one plays on any kit tier — watch them loop in the preview. The WA 3.10.0 additions are `flip-360`, `spin-snap*`, `buzz`, `float`, `jello`, `swing`, and `wag`.',
    ),
    ex(
      'Every canvas mode',
      canvasGallery(),
      'The **canvas** is the box an icon sits in — it changes the box, not the glyph. Each mode shows the same five different-width icons in a tinted, dashed box so the reserved spacing is visible: `fixed` (default) gives every icon the same box so they line up; `auto` lets each take its natural width; `square` and `roomy` are larger uniform boxes.',
    ),

    heading('Format date'),
    ex('Inline', 'Published [[[2026-06-26 style:long]]].'),
    ...['short', 'medium', 'full'].map((s) =>
      ex(`Style: ${s}`, `:::wa-format-date 2026-06-26 style:${s}\n:::`),
    ),
    ex('With time', ':::wa-format-date 2026-06-26T14:30:00Z style:medium time:short\n:::'),
    ex('French locale', ':::wa-format-date 2026-06-26 style:full lang:fr\n:::'),

    heading('Relative time'),
    ex('Inline', 'Updated [[[relative 2026-06-20]]].'),
    ...['short', 'narrow'].map((f) =>
      ex(`Format: ${f}`, `:::wa-relative-time 2026-06-20 format:${f}\n:::`),
    ),
    ex('Numeric: always', ':::wa-relative-time 2026-06-20 numeric:always\n:::'),
    ex('Live-ticking', ':::wa-relative-time 2026-06-20 sync\n:::', 'The `sync` flag keeps the phrase ticking as time passes.'),
  ],
});

// 7. Media ------------------------------------------------------------------
categories.push({
  id: 'media',
  title: 'Media',
  intro: 'Carousels, before/after comparisons, video, and randomly-rotating content.',
  examples: [
    heading('Carousel'),
    ex(
      'Navigation + pagination',
      '~~~~~~navigation pagination\n~~~\nSlide one\n~~~\n~~~\nSlide two\n~~~\n~~~\nSlide three\n~~~\n~~~~~~',
      'Separate slides with `~~~`. Toggle arrows with `navigation` and dots with `pagination`.',
    ),
    ex(
      'Autoplay + loop',
      '~~~~~~autoplay autoplay-interval:2500 loop pagination\n~~~\nAuto-advances every 2.5s\n~~~\n~~~\n…then loops back\n~~~\n~~~~~~',
    ),
    ex(
      'Image slides',
      '~~~~~~navigation loop\n~~~\n![First](../assets/photo.jpg)\n~~~\n~~~\n![Second](../assets/before.jpg)\n~~~\n~~~~~~',
    ),

    heading('Comparison'),
    ex(
      'Before / after',
      '|||\n![Before](../assets/before.jpg)\n![After](../assets/photo.jpg)\n|||',
      'Exactly two images: the first is the “before” slot, the second the “after”. Drag the slider.',
    ),
    ex(
      'Custom start position',
      '|||25\n![Before](../assets/before.jpg)\n![After](../assets/photo.jpg)\n|||',
      'A number (0–100) sets the initial slider position.',
    ),

    heading('Video'),
    ex(
      'Standard controls',
      ';;;\n[Sample clip](../assets/video.mp4)\n![Poster](../assets/poster.jpg)\n;;;',
      'The first link supplies the title and src; the first image supplies the poster. `<wa-video>` is Web Awesome Pro.',
    ),
    ex(
      'Full controls',
      ';;;controls:full\n[Sample clip](../assets/video.mp4)\n![Poster](../assets/poster.jpg)\n;;;',
    ),

    heading('Random content'),
    ex(
      'Random tip',
      '......mode:random items:1 animation:fade\nTip: press ⌘K to search.\n>>>\nTip: star the repo to follow releases.\n>>>\nTip: callouts support animated icons.\n......',
      'Shows a random subset of its options and hides the rest — zero JavaScript to author.',
    ),
    ex(
      'Autoplay rotation',
      '......mode:random items:1 autoplay autoplay-interval:3000 animation:fade-up\n“Best component library I’ve used.”\n>>>\n“Shipped our marketing site in a weekend.”\n>>>\n“The docs are excellent.”\n......',
    ),
  ],
});

// 8. Layouts ----------------------------------------------------------------
categories.push({
  id: 'layouts',
  title: 'Layouts',
  intro:
    'Zero-media-query layout primitives that map to Web Awesome CSS utilities: grid, stack, ' +
    'cluster, split, flank, and frame.',
  examples: [
    heading('Grid'),
    ex(
      'Auto-adaptive columns',
      '::::grid gap:l min:200px\n===accent\n# One\nWraps responsively.\n===\n\n===accent\n# Two\nNo media queries.\n===\n\n===accent\n# Three\nAuto columns.\n===\n::::',
      'Children wrap based on `min` column size — resize the window to see it reflow.',
    ),

    heading('Stack'),
    ex(
      'Vertical rhythm',
      '::::stack gap:m\n:::info\nFirst item\n:::\n\n:::success\nSecond item\n:::\n\n:::warning\nThird item\n:::\n::::',
      'Consistent vertical spacing between blocks.',
    ),

    heading('Cluster'),
    ex(
      'Wrapping tag row',
      '::::cluster gap:s\n@@@brand\nRuby\n@@@\n@@@success\nJekyll\n@@@\n@@@neutral\nEleventy\n@@@\n@@@warning\nMarkdown\n@@@\n::::',
      'Inline items that wrap — great for tag clouds and button rows.',
    ),

    heading('Split'),
    ex(
      'Opposite ends',
      '::::split\n<strong>© 2026 Markawesome</strong>\n<span><a href="/privacy">Privacy</a> · <a href="/terms">Terms</a></span>\n::::',
      'Pushes children to opposite ends of the row — the classic header/footer pattern. Put HTML or components (not bare Markdown) directly inside layout containers.',
    ),

    heading('Flank'),
    ex(
      'Sidebar + content',
      '::::flank start size:160px gap:l\n<img src="../assets/thumb.jpg" alt="Thumbnail">\n:::info\nThe 160px sidebar stays fixed while the content flexes — both wrap to one column on narrow screens.\n:::\n::::',
    ),

    heading('Frame'),
    ...['landscape', 'portrait', 'square'].map((r) =>
      ex(
        `Aspect ratio: ${r}`,
        `::::frame ${r} radius:l\n<img src="../assets/photo.jpg" alt="${r} frame">\n::::`,
      ),
    ),
  ],
});

// --- YAML emitter ----------------------------------------------------------
// Hand-rolled so the output is stable and byte-identical across runs. Scalars
// are always double-quoted (unambiguous strings in both Ruby Psych and
// js-yaml — no YAML 1.1 yes/no coercion); multi-line code/intro use literal
// block scalars.

const q = (s) => '"' + String(s).replace(/\\/g, '\\\\').replace(/"/g, '\\"') + '"';

function block(s, indent) {
  const pad = ' '.repeat(indent);
  const lines = String(s).replace(/\n$/, '').split('\n');
  return '|\n' + lines.map((l) => (l.length ? pad + l : '')).join('\n');
}

let out = '# Generated by scripts/build-dataset.mjs from markawesome-vscode components.json.\n';
out += '# Shared, byte-identical across jekyll-webawesome and eleventy-plugin-webawesome.\n';
out += `title: ${q('Web Awesome Component Examples')}\n`;
out += 'categories:\n';
for (const cat of categories) {
  out += `  - id: ${q(cat.id)}\n`;
  out += `    title: ${q(cat.title)}\n`;
  if (cat.intro) out += `    intro: ${block(cat.intro, 6)}\n`;
  out += '    examples:\n';
  for (const item of cat.examples) {
    if (item.heading) {
      out += `      - heading: ${q(item.heading)}\n`;
      continue;
    }
    out += `      - title: ${q(item.title)}\n`;
    if (item.description) out += `        description: ${q(item.description)}\n`;
    out += `        code: ${block(item.code, 10)}\n`;
  }
}

fs.writeFileSync(outPath, out);
const exampleCount = categories.reduce(
  (n, c) => n + c.examples.filter((e) => !e.heading).length,
  0,
);
console.error(
  `Wrote ${outPath}: ${categories.length} categories, ${exampleCount} examples ` +
    `(${byName ? Object.keys(byName).length : 0} components in catalogue).`,
);
