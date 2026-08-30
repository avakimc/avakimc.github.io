import { defineCollection } from 'astro:content';
import { z } from 'astro/zod';
import { glob } from 'astro/loaders';

/** A labelled external link, rendered as a pill under an entry. */
const link = z.object({
  label: z.string(),
  url: z.url(),
});

/** An image with required alt text. Alt is required by schema, not by convention. */
const media = z.object({
  src: z.string(),
  alt: z.string(),
  caption: z.string().optional(),
  /** Intrinsic pixel size. Set both so the browser reserves space before load. */
  width: z.number().optional(),
  height: z.number().optional(),
});

const experience = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/experience' }),
  schema: z.object({
    org: z.string(),
    orgNote: z.string().optional(),
    role: z.string(),
    location: z.string(),
    dates: z.string(),
    order: z.number(),
    tags: z.array(z.string()).default([]),
    links: z.array(link).default([]),
  }),
});

const projects = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/projects' }),
  schema: z.object({
    title: z.string(),
    context: z.string().optional(),
    role: z.string().optional(),
    dates: z.string(),
    order: z.number(),
    tags: z.array(z.string()).default([]),
    links: z.array(link).default([]),
    media: z.array(media).default([]),
  }),
});

const research = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/research' }),
  schema: z.object({
    title: z.string(),
    venue: z.string(),
    year: z.number(),
    url: z.url(),
    authorNote: z.string().optional(),
    /** id of the experience entry this came out of; renders under that entry. */
    experience: z.string(),
    order: z.number(),
    /** Set false once the real paper title replaces the placeholder. */
    titlePending: z.boolean().default(false),
  }),
});

export const collections = { experience, projects, research };
