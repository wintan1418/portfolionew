# Wintan Portfolio & Outreach System

## Project Overview
Personal portfolio/outreach system for Oluwadare Juwon (WINTAN) - Full-Stack Software Engineer, Rails expert, AI enthusiast. Built with Rails 8.1 + Hotwire + Tailwind CSS v4.

## Tech Stack
- Ruby 3.4 / Rails 8.1
- PostgreSQL
- Tailwind CSS v4 (via tailwindcss-rails, configured in `app/assets/tailwind/application.css`)
- Hotwire: Turbo + Stimulus (via importmap, no Node.js/npm)
- Propshaft asset pipeline
- Solid Queue (background jobs), Solid Cache, Solid Cable, all in the single primary Postgres database (tables created by a regular migration)
- Active Storage (file uploads), Action Text (rich text)
- Deployment: Hatchbox

## Development Commands
- `bin/dev` - Start dev server (Rails + Tailwind watcher via Procfile.dev)
- `bin/rails test` - Run tests
- `bin/rails db:migrate` - Run migrations
- `bin/rails db:seed` - Seed database

## Architecture
- **Admin namespace** (`/admin/*`) - authenticated CRUD for all content
- **Public pages** - Hotwire-powered with Stimulus controllers for animations
- **Profile model** - Singleton pattern (`Profile.instance`)
- **Design system** - semantic tokens (`bg-base`, `text-ink`, `text-ink-2`, `border-line`, `.glass`, `.btn-*`, `.chip`, `.field`) defined in `app/assets/tailwind/application.css`; theme is `<html class="dark|light">`, toggled by `theme_controller.js`. Never use `text-white`/`surface-*` colours in public views.
- **Motion** - GSAP is loaded as a classic script from `vendor/assets/javascripts` and re-exported by `app/javascript/lib/gsap.js`; `reveal`, `hero`, `parallax`, `magnetic` Stimulus controllers drive animations. Keep it restrained: no floating decorations or glow blobs.
- **SEO** - `meta-tags` gem, sitemap, RSS feed, JSON-LD structured data

## Content
- Project catalogue lives in `db/seeds/projects.rb` with screenshots in `db/seeds/screenshots/<slug>/`; `bin/rails content:projects` upserts it (safe in production). `bin/rails content:github` refreshes GitHub counts.
- Never put changing counts (catalog sizes, model counts) in project copy.
- Images are served as uploaded (no Active Storage variants) because the production server has no libvips.

## Conventions
- Stimulus controllers in `app/javascript/controllers/` (auto-loaded via importmap)
- Shared view partials in `app/views/shared/` and `app/views/components/`
- Admin views in `app/views/admin/` with separate layout
- Slugs generated via `before_validation` (no friendly_id gem)
- PostgreSQL arrays for tech_stack/highlights fields
- `pagy` for pagination
