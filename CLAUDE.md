# Wintan Portfolio & Outreach System

## Project Overview
Personal portfolio/outreach system for Oluwadare Juwon (WINTAN) - Full-Stack Software Engineer, Rails expert, AI enthusiast. Built with Rails 8.0.4 + Hotwire + Tailwind CSS v4.

## Tech Stack
- Ruby 3.4.3 / Rails 8.0.4
- PostgreSQL
- Tailwind CSS v4 (via tailwindcss-rails, configured in `app/assets/tailwind/application.css`)
- Hotwire: Turbo + Stimulus (via importmap, no Node.js/npm)
- Propshaft asset pipeline
- Solid Queue (background jobs), Solid Cache, Solid Cable
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
- **Dark mode default** - toggled via `theme_controller.js` + localStorage
- **SEO** - `meta-tags` gem, sitemap, RSS feed, JSON-LD structured data

## Conventions
- Stimulus controllers in `app/javascript/controllers/` (auto-loaded via importmap)
- Shared view partials in `app/views/shared/` and `app/views/components/`
- Admin views in `app/views/admin/` with separate layout
- Slugs generated via `before_validation` (no friendly_id gem)
- PostgreSQL arrays for tech_stack/highlights fields
- `pagy` for pagination
