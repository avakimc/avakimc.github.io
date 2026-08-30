# avakimc.github.io

Personal site for Ava Kim Cohen — projects, research, and work experience.
Built with [Astro](https://astro.build) and Tailwind CSS, deployed to GitHub Pages.

See [SPEC.md](SPEC.md) for the full specification: content model, design decisions,
and the list of deliberately deferred work.

## Local development

```bash
npm install
npm run dev      # http://localhost:4321
npm run build    # production build into dist/
npm run check    # type + template diagnostics
```

## Editing content

Everything on the page comes from Markdown files in `src/content/` — no template
editing required:

- `src/content/experience/` — jobs and research positions
- `src/content/projects/` — personal and club projects
- `src/content/research/` — publications and preprints; each names the `experience`
  entry it came out of and renders beneath it (there is no separate research page)

Experience and projects each render as their own page (`/experience`, `/projects`);
the home page holds the about text, education, skills, and contact details. Adding a
Markdown file to a collection makes it appear on that page automatically — ordering
comes from the `order` field.

Each file has YAML frontmatter (validated at build time) plus a prose body. Several
files carry `<!-- EXPAND: ... -->` comments marking what to flesh out and where
screenshots belong.

To link out from inside a paragraph, write a plain HTML anchor rather than Markdown
link syntax, so the link opens in a new tab like every other outbound link:

```html
<a href="https://example.com" target="_blank" rel="noopener noreferrer">Link text</a>
```

Astro 7's default Markdown processor does not take rehype plugins without swapping the
processor, so this is done by hand. For a link that belongs to the whole entry rather than
to a sentence, use the `links` array instead — it renders as a pill and handles this
automatically.

An entry covering several systems can give each one its own stack line instead of sharing
the entry's `tags` row — write `<p class="stack">A · B · C</p>` at the end of that
subsection and leave `tags: []` in the frontmatter (see `experience/acorn.md`).

**Quote any frontmatter value containing `#`** — YAML reads an unquoted ` #` as the
start of a comment and will silently truncate the value.

To add a screenshot: drop the image in `public/media/`, then add it to that entry's
`media` array with `src`, `alt` (required), and an optional `caption`.

## Deployment

Pushing to `main` triggers `.github/workflows/deploy.yml`, which builds the site and
publishes it to GitHub Pages at https://avakimc.github.io.

Two one-time settings are required before the first deploy succeeds:

1. The repository must be **public** — GitHub Pages does not publish from a private
   repo on the free tier.
2. **Settings → Pages → Build and deployment → Source** must be set to **GitHub Actions**.
