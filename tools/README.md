# tools

Helpers for regenerating `public/og.png`, the 1200×630 link-preview card.

## og-crop.swift (what produced the current card)

Crops a region from a screenshot of the site and letterboxes it into a 1200×630 frame on
the site background, so the padding is invisible.

```bash
swift tools/og-crop.swift <in.png> <out.png> <x> <y> <width> <height>
sips -Z 1200 <out.png> --out <out.png>   # the draw is 2x; bring it back to 1200 wide
```

The card deliberately shows **only the name and subtitle**. An earlier version included the
bio, which then went stale the moment the bio was reworded — keep anything that changes out
of the image.

To remake it: screenshot the hero at a wide viewport, then crop to the name and subtitle.

## og-card.swift (drawn alternative, unused)

Draws a card from scratch in the site's palette — no screenshot needed. Useful if the
hero changes and retaking a screenshot is inconvenient.

```bash
swift tools/og-card.swift public/og.png
sips -Z 1200 public/og.png --out public/og.png
```

## pdf-retitle.swift

Browsers title a PDF tab from the file's internal Title attribute, not its filename. A
Google Docs export carries `<docname>.docx - Google Docs`, which is what a visitor sees
when the résumé opens in a tab. Rewrite it after every export:

```bash
swift tools/pdf-retitle.swift ~/Desktop/Resume.pdf public/AvaKimCohen_Resume.pdf \
  "Ava Kim Cohen — Resume" "Ava Kim Cohen"
```

It also clears the exporting browser's user-agent string from the Creator field, which
otherwise records the machine and browser version the PDF was made on.
