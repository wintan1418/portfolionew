# Portfolio project catalogue. Idempotent: upserts by slug and attaches the
# screenshots committed under db/seeds/screenshots/<slug>/ when they are
# missing. Run with `bin/rails content:projects` (safe on production).

SHOTS = Rails.root.join("db/seeds/screenshots")

def attach_shots!(project)
  dir = SHOTS.join(project.slug)
  return unless dir.directory?

  hero = dir.join("hero.jpg")
  if hero.exist? && (!project.cover_image.attached? || project.cover_image.blob.checksum != Digest::MD5.file(hero).base64digest)
    project.cover_image.attach(io: File.open(hero), filename: "#{project.slug}-hero.jpg", content_type: "image/jpeg")
  end

  wanted = Dir[dir.join("*.jpg")].map { |f| "#{project.slug}-#{File.basename(f)}" }
  project.images.each { |img| img.purge if img.filename.to_s.start_with?("#{project.slug}-") && !wanted.include?(img.filename.to_s) }

  Dir[dir.join("*.jpg")].sort.each do |path|
    name = File.basename(path)
    next if name == "hero.jpg"

    filename = "#{project.slug}-#{name}"
    checksum = Digest::MD5.file(path).base64digest
    current = project.images.find { |i| i.filename.to_s == filename }
    next if current && current.blob.checksum == checksum

    current&.purge
    project.images.attach(io: File.open(path), filename: filename, content_type: "image/jpeg")
  end
end

UNI_GRIP_STACK = [ "Ruby on Rails 8", "Hotwire", "PostgreSQL", "Tailwind CSS", "Active Storage", "Solid Queue", "OpenAI API" ].freeze
SCHOOL_STACK   = [ "Ruby on Rails 8", "Hotwire", "PostgreSQL", "Tailwind CSS", "Devise", "Pundit", "Paystack", "Solid Queue", "OpenAI API" ].freeze

PROJECTS = [
  {
    slug: "uni-grip", category: "Manufacturing catalog", metrics: nil, title: "Uni-Grip", position: 1, featured: true, project_type: "client", family: "uni-grip",
    live_url: "https://uni-grip.com", client_name: "Uni-Grip Inc.", role: "Solo build, end to end",
    completed_on: Date.new(2026, 9, 1), status: "active", accent_color: "#0ea5e9",
    tagline: "A searchable seal catalog and quote flow for an American manufacturer founded in 1963.",
    summary: "Uni-Grip has made rubber and plastic extruded seals in Ohio since 1963. Their new site turns a paper catalog into Sealfinder: search by dimension, profile, material or part number, compare profiles side by side, build a quote list and ask an assistant that knows the catalog.",
    highlights: [
      "Sealfinder: every profile searchable by dimension, material, style or part number, with interchange links between equivalent profiles",
      "Compare up to three profiles, build a quote list, request samples and export the list to CSV",
      "Guided RV path that finds a replacement slide-out seal in three questions, no part number needed",
      "Catalog-aware chat assistant that answers product questions and hands off to staff",
      "Cross-section drawings and downloadable dimensioned spec sheets on every profile",
      "Hotwire throughout: instant filtering and search with no page reloads"
    ],
    tech_stack: UNI_GRIP_STACK,
    challenge: "Uni-Grip sells a large range of extruded profiles to RV, marine, construction and military buyers who usually arrive with a dimension or a competitor's part number, not a Uni-Grip SKU. The old site could not answer either question, so every lead went through the phone.",
    solution: "I modelled the catalog properly (profiles, families, materials, dimensions and interchange links), built a fast search and filter layer with Turbo Frames, and added a quote list that follows the visitor through the site. A small assistant on top of the catalog data handles the long tail of questions. The same engine now powers two sister brands.",
    results: "The catalog, quote flow and assistant went live on uni-grip.com in 2026 and the same codebase was adapted for Trim-Gard and Cowles Products."
  },
  {
    slug: "trim-gard", category: "Automotive catalog", title: "Trim-Gard", position: 2, featured: true, project_type: "client", family: "uni-grip",
    live_url: "https://trim-gard.com", client_name: "Trim-Gard", role: "Solo build, end to end",
    completed_on: Date.new(2026, 9, 1), status: "active", accent_color: "#dc2626",
    tagline: "Automotive moldings and custom extrusions, with a trim finder built for restorers and fleets.",
    summary: "Trim-Gard makes body side moldings, door edge guards, wheel well trim and custom profiles to a customer's drawing. The site routes restoration, fleet, performance and manufacturing buyers to the right products and a quote request.",
    highlights: [
      "Trim Finder: live search over the full profile catalog with per-profile dimensions and compound",
      "Find-your-vehicle fitment path and installation guides",
      "Quote-driven flow: no cart, every product leads to a drawing-based quote request",
      "\"Ask the workshop\" assistant for product and installation questions",
      "ISO 9001:2015 and materials pages built as structured content, editable by staff"
    ],
    tech_stack: UNI_GRIP_STACK,
    challenge: "Three brands under one manufacturer, each with its own identity and audience, but the same catalog data and quote process underneath.",
    solution: "The Uni-Grip engine was extended with brand-level theming, audience landing pages and a vehicle fitment path, so Trim-Gard shares the catalog and admin while looking and reading like its own company.",
    results: "Launched alongside Uni-Grip and Cowles Products in 2026 as part of a three-site family."
  },
  {
    slug: "cowles-products", category: "Product catalog", title: "Cowles Products", position: 3, featured: true, project_type: "client", family: "uni-grip",
    live_url: "https://cowlesproducts.com", client_name: "Cowles Products", role: "Solo build, end to end",
    completed_on: Date.new(2026, 9, 1), status: "active", accent_color: "#b91c1c",
    tagline: "Flexible chrome molding, cut to length, with a catalog and quote flow built for resellers.",
    summary: "Cowles Custom makes chrome and clear protective molding for grilles, body lines, mirrors and bumpers. The site is a product catalog with shop-by-family browsing, a trim finder, finishes, videos and a reseller route.",
    highlights: [
      "Shop-by-family browsing across the product range",
      "Trim Finder with search-as-you-type over part number, dimension, style and material",
      "Quote list, compare panel and CSV download shared with the sister sites",
      "Reseller contact route and sample requests",
      "\"Ask Cowles\" catalog assistant"
    ],
    tech_stack: UNI_GRIP_STACK,
    challenge: "Cowles sells through resellers and directly, with a chrome aesthetic that had to feel premium while reusing the catalog engine built for industrial seals.",
    solution: "Brand theming, a finishes section and video content were added on top of the shared engine, with a reseller-specific contact path.",
    results: "Third site in the Uni-Grip family, live in 2026."
  },
  {
    slug: "system-or-ecosystem", category: "Publishing platform", title: "System or Ecosystem", position: 4, featured: true, project_type: "client", family: nil,
    live_url: "https://systemorecosystem.com", client_name: "System or Ecosystem", role: "Rebuild contributor",
    completed_on: Date.new(2026, 6, 1), status: "active", accent_color: "#65743a",
    tagline: "A multilingual publishing site giving away books, audiobooks and printed copies worldwide.",
    summary: "The System or The Ecosystem offers its books free in several languages, with audiobooks, videos, reader stories and a request flow for free printed copies shipped anywhere. I contributed to the rebuild of the site on Rails.",
    highlights: [
      "Multilingual content model with a language switcher",
      "Free hardcopy request flow with worldwide shipping",
      "Audiobook and video sections, reader testimonials and a historical timeline",
      "Cloudinary-backed media with modern formats such as AVIF"
    ],
    tech_stack: [ "Ruby on Rails", "Hotwire", "PostgreSQL", "Cloudinary", "Tailwind CSS", "I18n" ]
  },
  {
    slug: "lvhs", category: "Education platform", metrics: nil, title: "Life Veneration High School", position: 5, featured: true, project_type: "client", family: "school-platform",
    live_url: "https://lvhs.ng", client_name: "Life Veneration High School", role: "Solo build, end to end",
    completed_on: Date.new(2026, 3, 1), status: "active", accent_color: "#166534",
    tagline: "A school operating system: admissions, portals, fees, e-learning and staff attendance for a secondary school.",
    summary: "LVHS runs most of its day-to-day operations on this platform. Prospective families apply online, parents and students have portals, teachers manage classes and content, and staff clock in on an ATM-style attendance kiosk. A native Android shell wraps the same app.",
    highlights: [
      "Separate portals for applicants, parents, students, teachers, alumni and staff with role-based access (Devise and Pundit)",
      "Admissions and fee payments with Paystack",
      "E-learning area, calendar, news and careers pages managed by school staff",
      "ATM-style staff attendance kiosk with PIN pads and salary-deduction rules",
      "Native Android app built as a 200-line Kotlin WebView shell with auto-updates outside the Play Store",
      "Background jobs on Solid Queue and AI-assisted content for staff"
    ],
    tech_stack: SCHOOL_STACK + [ "Kotlin" ]
  },
  {
    slug: "lifeglow", category: "Education platform", title: "Life Glow Primary School", position: 6, featured: true, project_type: "client", family: "school-platform",
    live_url: "https://lifeglow.ng", client_name: "Life Glow Primary School", role: "Solo build, end to end",
    completed_on: Date.new(2026, 9, 1), status: "active", accent_color: "#15803d",
    tagline: "The school platform, adapted for a nursery and primary school where every child is known by name.",
    summary: "A second deployment of the school platform, re-themed and adapted for younger pupils: admissions with fees and FAQ, school life, calendar, news, careers and a family portal.",
    highlights: [
      "Shared platform with LVHS, with its own brand, content and admissions rules",
      "Family portal, admissions and online fee payment",
      "School staff edit every public page without a developer"
    ],
    tech_stack: SCHOOL_STACK
  },
  {
    slug: "rezumfit", category: "SaaS platform", title: "RezumFit", position: 7, featured: true, project_type: "product", family: nil,
    live_url: "https://rezumfit.com", github_url: "https://github.com/wintan1418/rezum", role: "Founder and engineer",
    completed_on: Date.new(2025, 3, 1), status: "active", accent_color: "#4f46e5",
    tagline: "AI career tools that tailor your real resume to a job without inventing experience.",
    summary: "RezumFit rewrites an existing resume for a specific job listing, computes an ATS match rate and keyword gaps, and generates cover letters, interview prep and LinkedIn copy. It sells credits and monthly plans.",
    highlights: [
      "ATS match scoring and keyword-gap analysis against a pasted job listing",
      "Resume tailoring, cover letters, interview prep, LinkedIn optimisation and pitch decks on one credit system",
      "Job scraper and application tracker",
      "Free tier plus pay-as-you-go credits and Pro and Premium subscriptions",
      "Background processing with Sidekiq, analytics with Ahoy, media on Cloudinary"
    ],
    tech_stack: [ "Ruby on Rails", "Hotwire", "PostgreSQL", "OpenAI API", "Sidekiq", "Redis", "Cloudinary", "Stripe", "Tailwind CSS" ]
  },
  {
    slug: "railsai-kit", category: "Developer product", metrics: nil, title: "RailsAI Kit", position: 8, featured: true, project_type: "product", family: nil,
    live_url: "https://saasrailskit.com", role: "Author", completed_on: Date.new(2026, 7, 1), status: "active", accent_color: "#e11d48",
    tagline: "The AI layer of your SaaS, already built. A Rails 8.1 starter kit sold to developers.",
    summary: "A commercial starter kit for Rails developers who want the AI parts done: streaming chat across providers, document Q&A on pgvector, usage-based credit billing, auth, multi-tenant workspaces and an admin dashboard. Sold as a one-time purchase with update windows.",
    highlights: [
      "Multi-provider streaming chat over Turbo Streams",
      "Document ingestion and retrieval with pgvector and the neighbor gem",
      "Usage-based credit metering and billing with Stripe and Paystack",
      "Multi-tenant workspaces with acts_as_tenant, roles and invitations",
      "Admin dashboard, docs site and changelog",
      "Licensed per project with tiered update windows"
    ],
    tech_stack: [ "Ruby on Rails 8.1", "Hotwire", "PostgreSQL", "pgvector", "Stripe", "Paystack", "Sidekiq", "OpenAI API", "Anthropic API" ]
  },
  {
    slug: "bibliorata", category: "Study app", title: "BiblioRata", position: 9, featured: true, project_type: "product", family: nil,
    live_url: "https://bibliorata.com", role: "Founder and engineer", completed_on: Date.new(2026, 9, 1), status: "active", accent_color: "#7c2d12",
    tagline: "A free, offline-capable Bible study desk with side-by-side translations and live projection for churches.",
    summary: "BiblioRata works without an account and offline. Study mode lays up to four translations side by side with cross-references and a Strong's lexicon; Preach mode projects Scripture live with a phone as the remote. An AI assistant only points to references.",
    highlights: [
      "Several translations side by side with cross-references",
      "Strong's lexicon, reading plans, notes, highlights and memorisation tools",
      "Preach mode: live projection controlled from a phone remote over Action Cable",
      "Works offline and without an account",
      "Reference-only AI assistant that never paraphrases Scripture"
    ],
    tech_stack: [ "Ruby on Rails 8", "Hotwire", "Action Cable", "PostgreSQL", "Service Worker", "Cloudinary", "OpenAI API" ]
  },
  {
    slug: "arolel", category: "Utility suite", title: "Arolel", position: 10, featured: true, project_type: "product", family: nil,
    live_url: "https://arolel.com", role: "Founder and engineer", completed_on: Date.new(2026, 10, 1), status: "active", accent_color: "#16a34a",
    tagline: "Everyday file tools in one Rails app, with privacy up front.",
    summary: "HEIC to JPG, PDF merge and split, image compression, uptime checks, bulk URL opening, invoice and contract makers, PDF signing and media conversion. Most tools run in the browser; conversions only touch the server when they must.",
    highlights: [
      "Browser-first processing so files never leave the device unless a tool needs the server",
      "PDF tools: merge, split, rotate, compress, convert and sign",
      "Document makers for invoices and contracts with saved templates",
      "Live session counter showing exactly what has been uploaded or tracked (nothing)",
      "Optional accounts for saving work, no tracking cookies"
    ],
    tech_stack: [ "Ruby on Rails 8", "Hotwire", "PostgreSQL", "Solid Queue", "Active Storage", "JavaScript" ]
  },
  {
    slug: "brethreign", category: "Community platform", title: "Brethreign", position: 11, featured: true, project_type: "product", family: nil,
    live_url: "https://brethreign.com", role: "Founder and engineer", completed_on: Date.new(2026, 10, 1), status: "active", accent_color: "#22c55e",
    tagline: "A faith community platform: feed, rooms, prayer requests and a library.",
    summary: "Members share posts, prayer requests, testimonies and encouragement in a public feed and themed rooms such as Prayer Requests and Brethren-in-Tech, with a resource library and search.",
    highlights: [
      "Public feed with recent, trending and following views",
      "Themed rooms with their own post types and moderation",
      "Library of discipleship and worship resources",
      "Search across posts, rooms and library"
    ],
    tech_stack: [ "Ruby on Rails 8", "Hotwire", "PostgreSQL", "Devise", "Cloudinary", "Solid Queue", "Pagy" ]
  },
  {
    slug: "boaner", category: "Personal site", title: "Boaner", position: 12, featured: false, project_type: "client", family: nil,
    live_url: "https://boaner.com", client_name: "Boaner", role: "Solo build", completed_on: Date.new(2026, 4, 1), status: "active", accent_color: "#f59e0b",
    tagline: "A personal publishing site for a teacher and YouTuber: videos, blog, courses, books and newsletter.",
    summary: "A living library for a history and language teacher. Videos, long-form articles, courses and books, with a reading list and a free newsletter, all managed from a Rails admin.",
    highlights: [ "Video, blog, course and book content types", "Newsletter signup and reading list", "Owner-editable pages with Action Text" ],
    tech_stack: [ "Ruby on Rails 8", "Hotwire", "PostgreSQL", "Devise", "Solid Queue", "Tailwind CSS" ]
  },
  {
    slug: "the-man-christ-jesus", category: "Book launch site", title: "The Man Christ Jesus", position: 13, featured: false, project_type: "client", family: nil,
    live_url: "https://themanchristjesus.africa", client_name: "FMELi", role: "Solo build", completed_on: Date.new(2026, 8, 1), status: "active", accent_color: "#ca8a04",
    tagline: "A book launch site with chapter previews, reader testimonies and pay-on-delivery reservations.",
    summary: "Promotional site for a book: the book, a chapter list with a read-a-page excerpt, the author, a testimonies form and an order reservation flow for the paperback.",
    highlights: [ "Read-a-page excerpt and chapter index", "Testimonies submission and moderation", "Order reservation with pay-on-delivery" ],
    tech_stack: [ "Ruby on Rails 8", "Hotwire", "PostgreSQL", "Tailwind CSS" ]
  },
  {
    slug: "tenant-kit", category: "Rails gem", title: "tenant_kit", position: 14, featured: false, project_type: "open_source", family: nil,
    github_url: "https://github.com/wintan1418/tenant_kit", role: "Author", completed_on: Date.new(2026, 7, 1), status: "active", accent_color: "#a78bfa",
    tagline: "Row-level, shared-schema multi-tenancy for Rails. Strict by default, with background-job support.",
    summary: "A gem that scopes every query to the current tenant, refuses to run unscoped by default, and carries the tenant through Active Job so background work stays isolated.",
    highlights: [ "Strict mode raises on unscoped queries", "Tenant context propagated through Active Job", "Works with shared-schema PostgreSQL" ],
    tech_stack: [ "Ruby", "Rails", "Active Record", "Active Job" ]
  }
]

# Existing lab projects from the earlier portfolio: keep them, but group them.
LAB_SLUGS = %w[crypcop-solana-token-scanner railsy-commerce this-is-that local-hub naijahomes].freeze
LAB_RENAMES = { "Live ven" => "lvhs", "Roster" => "rosterflow" }.freeze

LAB_RENAMES.each do |old_slug, new_slug|
  next unless (legacy = Project.find_by(slug: old_slug))

  if new_slug == "lvhs"
    # Carry the old LVHS record forward under the new slug.
    legacy.update!(slug: new_slug)
  else
    legacy.update!(slug: new_slug)
  end
end

PROJECTS.each do |attrs|
  project = Project.find_or_initialize_by(slug: attrs[:slug])
  project.assign_attributes(attrs)
  project.save!
  attach_shots!(project)
  puts "  ✓ #{project.title} (cover=#{project.cover_image.attached?}, gallery=#{project.images.count})"
end

Project.where(slug: LAB_SLUGS).update_all(project_type: "lab", featured: false)
if (roster = Project.find_by(slug: "rosterflow"))
  roster.update!(project_type: "lab", featured: false, position: 20, tech_stack: [ "JavaScript", "React", "Vercel" ]) if roster.tech_stack.blank?
  roster.update!(project_type: "lab", featured: false)
  attach_shots!(roster)
end
Project.where(project_type: "lab").order(:position).each_with_index { |pr, i| pr.update_columns(position: 20 + i) }
Project.find_by(slug: "railsy-commerce")&.then { |pr| attach_shots!(pr) }
Project.find_by(slug: "local-hub")&.then { |pr| attach_shots!(pr) }

# Placeholder testimonials seeded by the original template, never real clients.
removed = Testimonial.where(author_name: [ "Alex Thompson", "Sarah Chen", "Michael Okonkwo" ]).destroy_all
puts "  removed #{removed.size} placeholder testimonials" if removed.any?

# Make sure orientation metadata exists so galleries can split desktop/mobile.
ActiveStorage::Blob.find_each do |blob|
  next if blob.analyzed?

  blob.analyze
rescue StandardError => e
  puts "  (skip analyze #{blob.filename}: #{e.message})"
end

# Profile tidy-up: the template left a markdown quote marker in the bio.
profile = Profile.instance
profile.bio = profile.bio.to_s.sub(/\A\s*>\s*/, "").sub(/\.\s*>\s*/, ". ") if profile.bio.present?
profile.years_experience ||= 6
profile.headline = "Full-Stack Engineer & SaaS Architect" if profile.headline.blank? || profile.headline.downcase.include?("rezumfit")
profile.bio = "I build thoughtful, scalable web applications that turn ideas into real products. I help individuals and businesses design, develop and scale digital solutions with modern technologies." if profile.bio.blank? || profile.bio.include?("SaaS Architect.")
profile.save!(validate: false)
Project.where(category: nil).find_each { |pr| pr.update_columns(category: pr.project_type == "lab" ? "Experiment" : pr.type_label) }

puts "Projects: #{Project.count} (#{Project.featured.count} featured)"
