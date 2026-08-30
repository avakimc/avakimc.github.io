// @ts-check
import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';

// User site (repo: avakimc.github.io) serves from the domain root.
// Do NOT add `base` unless this becomes a project repo again.
export default defineConfig({
  site: 'https://avakimc.github.io',
  vite: {
    plugins: [tailwindcss()],
  },
});
