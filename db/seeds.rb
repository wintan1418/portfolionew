puts "Seeding..."

# ──────────────────────────────────────────────
# Admin User
# ──────────────────────────────────────────────
User.find_or_create_by!(email_address: "admin@wintan.dev") do |user|
  user.password = "password123"
  puts "  Created admin user: admin@wintan.dev / password123"
end

# ──────────────────────────────────────────────
# Profile
# ──────────────────────────────────────────────
profile = Profile.find_or_create_by!(first_name: "Oluwadare") do |p|
  p.last_name = "Juwon"
  p.headline = "Full-Stack Software Engineer | Ruby on Rails Expert | AI Enthusiast"
  p.bio = "Full-stack software developer with 6+ years of experience building scalable, production-grade applications. Currently expanding expertise in AI, DevOps, GraphQL, and system design."
  p.about = "I'm Oluwadare Juwon, a passionate full-stack software developer based in Nigeria with over 6 years of experience building scalable web applications. I specialize in Ruby on Rails and modern JavaScript frameworks, and I'm deeply interested in AI and how it can transform the way we build software.\n\nI created RezumFit, an AI-powered resume builder, and have contributed to numerous open-source projects. When I'm not coding, I'm exploring new technologies, writing technical articles, or collaborating with other developers."
  p.email = "juwonoluwadare@gmail.com"
  p.location = "Nigeria"
  p.github_url = "https://github.com/wintan1418"
  p.linkedin_url = "https://www.linkedin.com/in/oluwintan/"
  p.twitter_url = "https://twitter.com/juwonoluwadare"
  p.website_url = "https://oluwintan.com"
  p.available_for_hire = true
  p.availability_text = "Available for remote opportunities"
  p.meta_description = "Oluwadare Juwon — Full-Stack Software Engineer specializing in Ruby on Rails, React, and AI. 6+ years building production-grade applications."
end
puts "  Profile: #{profile.full_name}"

# ──────────────────────────────────────────────
# Skills
# ──────────────────────────────────────────────
skills_data = [
  # Backend
  { name: "Ruby on Rails", category: "Backend", proficiency: 95, featured: true, position: 1 },
  { name: "Ruby", category: "Backend", proficiency: 95, featured: true, position: 2 },
  { name: "Node.js", category: "Backend", proficiency: 80, featured: true, position: 3 },
  { name: "Python", category: "Backend", proficiency: 70, featured: false, position: 4 },
  { name: "GraphQL", category: "Backend", proficiency: 75, featured: true, position: 5 },
  { name: "REST APIs", category: "Backend", proficiency: 90, featured: false, position: 6 },
  { name: "Sidekiq", category: "Backend", proficiency: 85, featured: false, position: 7 },

  # Frontend
  { name: "React", category: "Frontend", proficiency: 85, featured: true, position: 1 },
  { name: "JavaScript/ES6+", category: "Frontend", proficiency: 90, featured: true, position: 2 },
  { name: "TypeScript", category: "Frontend", proficiency: 75, featured: false, position: 3 },
  { name: "Tailwind CSS", category: "Frontend", proficiency: 90, featured: true, position: 4 },
  { name: "Hotwire (Turbo + Stimulus)", category: "Frontend", proficiency: 85, featured: true, position: 5 },
  { name: "HTML/CSS", category: "Frontend", proficiency: 95, featured: false, position: 6 },
  { name: "Vue.js", category: "Frontend", proficiency: 65, featured: false, position: 7 },

  # DevOps
  { name: "Docker", category: "DevOps", proficiency: 80, featured: true, position: 1 },
  { name: "AWS", category: "DevOps", proficiency: 70, featured: false, position: 2 },
  { name: "CI/CD", category: "DevOps", proficiency: 80, featured: false, position: 3 },
  { name: "Heroku", category: "DevOps", proficiency: 85, featured: false, position: 4 },
  { name: "Hatchbox", category: "DevOps", proficiency: 85, featured: false, position: 5 },
  { name: "Linux/Ubuntu", category: "DevOps", proficiency: 80, featured: false, position: 6 },
  { name: "Nginx", category: "DevOps", proficiency: 75, featured: false, position: 7 },

  # Tools
  { name: "PostgreSQL", category: "Tools", proficiency: 90, featured: true, position: 1 },
  { name: "MongoDB", category: "Tools", proficiency: 75, featured: true, position: 2 },
  { name: "Redis", category: "Tools", proficiency: 80, featured: true, position: 3 },
  { name: "Git/GitHub", category: "Tools", proficiency: 95, featured: false, position: 4 },
  { name: "RSpec", category: "Tools", proficiency: 85, featured: false, position: 5 },
  { name: "Minitest", category: "Tools", proficiency: 80, featured: false, position: 6 },
  { name: "Elasticsearch", category: "Tools", proficiency: 65, featured: false, position: 7 }
]

skills_data.each do |attrs|
  Skill.find_or_create_by!(name: attrs[:name]) do |s|
    s.assign_attributes(attrs)
  end
end
puts "  Skills: #{Skill.count} created"

# ──────────────────────────────────────────────
# Experiences
# ──────────────────────────────────────────────
experiences_data = [
  {
    company: "Freelance / Independent",
    role: "Senior Full-Stack Developer",
    description: "Building production-grade web applications for clients across various industries. Specializing in Ruby on Rails backends with modern frontend frameworks.",
    location: "Remote",
    start_date: Date.new(2022, 1, 1),
    current: true,
    employment_type: "freelance",
    highlights: [
      "Delivered 10+ full-stack applications for international clients",
      "Built AI-powered tools including RezumFit resume builder",
      "Maintained 100% client satisfaction rate",
      "Contributed to open-source Rails ecosystem"
    ],
    position: 1
  },
  {
    company: "Software Development",
    role: "Full-Stack Developer",
    description: "Developed and maintained web applications using Ruby on Rails and React. Collaborated with cross-functional teams to deliver features on tight deadlines.",
    location: "Nigeria",
    start_date: Date.new(2019, 6, 1),
    end_date: Date.new(2021, 12, 31),
    current: false,
    employment_type: "full-time",
    highlights: [
      "Built RESTful APIs consumed by web and mobile clients",
      "Implemented real-time features using ActionCable",
      "Reduced page load times by 40% through performance optimization",
      "Mentored junior developers on Rails best practices"
    ],
    position: 2
  },
  {
    company: "Tech Startup",
    role: "Junior Developer",
    description: "Started career building web applications and learning production-level software development. Focused on Ruby on Rails and JavaScript.",
    location: "Nigeria",
    start_date: Date.new(2018, 1, 1),
    end_date: Date.new(2019, 5, 31),
    current: false,
    employment_type: "full-time",
    highlights: [
      "Built and shipped first production Rails application",
      "Learned test-driven development with RSpec",
      "Implemented responsive designs with Bootstrap and custom CSS",
      "Participated in code reviews and agile sprints"
    ],
    position: 3
  }
]

experiences_data.each do |attrs|
  Experience.find_or_create_by!(company: attrs[:company], role: attrs[:role]) do |e|
    e.assign_attributes(attrs)
  end
end
puts "  Experiences: #{Experience.count} created"

# ──────────────────────────────────────────────
# Education
# ──────────────────────────────────────────────
Education.find_or_create_by!(institution: "University of Lagos") do |e|
  e.degree = "Bachelor's Degree"
  e.field_of_study = "Computer Science"
  e.start_date = Date.new(2014, 9, 1)
  e.end_date = Date.new(2018, 7, 1)
  e.description = "Studied computer science fundamentals including data structures, algorithms, database systems, and software engineering principles."
  e.position = 1
end
puts "  Education: #{Education.count} created"

# ──────────────────────────────────────────────
# Projects
# ──────────────────────────────────────────────
projects_data = [
  {
    title: "RezumFit",
    slug: "rezumfit",
    summary: "AI-powered resume builder that helps job seekers create professional, ATS-optimized resumes in minutes. Uses AI to suggest improvements and tailor content to job descriptions.",
    live_url: "https://rezumfit.com",
    github_url: "https://github.com/wintan1418/rezumfit",
    tech_stack: ["Ruby on Rails", "React", "OpenAI API", "PostgreSQL", "Tailwind CSS", "Sidekiq", "Redis"],
    featured: true,
    position: 1,
    completed_on: Date.new(2024, 3, 1),
    status: "active",
    project_type: "personal"
  },
  {
    title: "Winter Twitter Redesign",
    slug: "winter-twitter-redesign",
    summary: "A modern UI redesign concept for Twitter/X built with React. Features a clean, minimal interface with dark mode support and improved user experience.",
    github_url: "https://github.com/wintan1418/winter-twitter-redesign",
    tech_stack: ["React", "JavaScript", "CSS3", "Responsive Design"],
    featured: true,
    position: 2,
    completed_on: Date.new(2023, 6, 1),
    status: "completed",
    project_type: "personal"
  },
  {
    title: "LocalHub",
    slug: "local-hub",
    summary: "Community-driven platform connecting local businesses with customers. Features business listings, reviews, real-time messaging, and location-based search.",
    github_url: "https://github.com/wintan1418/local-hub",
    tech_stack: ["Ruby on Rails", "PostgreSQL", "ActionCable", "Stimulus", "Tailwind CSS", "MapBox"],
    featured: true,
    position: 3,
    completed_on: Date.new(2023, 9, 1),
    status: "completed",
    project_type: "personal"
  },
  {
    title: "NaijaHomes",
    slug: "naijahomes",
    summary: "Real estate listing platform for the Nigerian market. Users can list, search, and filter properties with advanced geolocation features.",
    github_url: "https://github.com/wintan1418/naijahomes",
    tech_stack: ["Ruby on Rails", "PostgreSQL", "Google Maps API", "Tailwind CSS", "Hotwire"],
    featured: false,
    position: 4,
    completed_on: Date.new(2023, 2, 1),
    status: "completed",
    project_type: "personal"
  },
  {
    title: "This_is_That",
    slug: "this-is-that",
    summary: "A comparison and decision-making web app that helps users weigh options side-by-side. Clean interface for evaluating choices across multiple criteria.",
    github_url: "https://github.com/wintan1418/This_is_That",
    tech_stack: ["Ruby on Rails", "JavaScript", "PostgreSQL", "Bootstrap"],
    featured: false,
    position: 5,
    completed_on: Date.new(2022, 8, 1),
    status: "completed",
    project_type: "personal"
  },
  {
    title: "Phaser Game",
    slug: "phaser-game",
    summary: "A 2D browser game built with the Phaser framework. Features sprite animations, physics engine, scoring system, and responsive canvas rendering.",
    github_url: "https://github.com/wintan1418/my-phaser-game",
    tech_stack: ["JavaScript", "Phaser.js", "HTML5 Canvas", "CSS3"],
    featured: false,
    position: 6,
    completed_on: Date.new(2021, 11, 1),
    status: "completed",
    project_type: "personal"
  }
]

projects_data.each do |attrs|
  Project.find_or_create_by!(slug: attrs[:slug]) do |p|
    p.assign_attributes(attrs)
  end
end
puts "  Projects: #{Project.count} created"

# ──────────────────────────────────────────────
# Social Links
# ──────────────────────────────────────────────
social_links_data = [
  { platform: "GitHub", url: "https://github.com/wintan1418", icon: "github", position: 1 },
  { platform: "LinkedIn", url: "https://www.linkedin.com/in/oluwintan/", icon: "linkedin", position: 2 },
  { platform: "Twitter/X", url: "https://twitter.com/juwonoluwadare", icon: "twitter", position: 3 }
]

social_links_data.each do |attrs|
  SocialLink.find_or_create_by!(platform: attrs[:platform]) do |s|
    s.assign_attributes(attrs)
  end
end
puts "  Social Links: #{SocialLink.count} created"

# ──────────────────────────────────────────────
# Blog Categories
# ──────────────────────────────────────────────
categories_data = [
  { name: "Ruby on Rails", slug: "ruby-on-rails", description: "Tutorials, tips, and insights about Ruby on Rails development", color: "#CC0000", position: 1 },
  { name: "AI & Machine Learning", slug: "ai-ml", description: "Exploring artificial intelligence and machine learning", color: "#8B5CF6", position: 2 },
  { name: "JavaScript", slug: "javascript", description: "JavaScript, React, and frontend development", color: "#F7DF1E", position: 3 },
  { name: "DevOps", slug: "devops", description: "Deployment, CI/CD, Docker, and infrastructure", color: "#06B6D4", position: 4 },
  { name: "Career", slug: "career", description: "Career advice, freelancing, and professional growth", color: "#10B981", position: 5 }
]

categories_data.each do |attrs|
  Category.find_or_create_by!(slug: attrs[:slug]) do |c|
    c.assign_attributes(attrs)
  end
end
puts "  Categories: #{Category.count} created"

# ──────────────────────────────────────────────
# Blog Posts (sample)
# ──────────────────────────────────────────────
rails_cat = Category.find_by(slug: "ruby-on-rails")
ai_cat = Category.find_by(slug: "ai-ml")
career_cat = Category.find_by(slug: "career")

posts_data = [
  {
    title: "Why I Rebuilt My Portfolio with Rails 8",
    slug: "why-i-rebuilt-my-portfolio-with-rails-8",
    excerpt: "After years of using React for my personal site, I switched to Rails 8. Here's why — and what I learned along the way.",
    status: "published",
    published_at: 2.days.ago,
    featured: true,
    reading_time: 8,
    category: rails_cat,
    meta_title: "Why I Rebuilt My Portfolio with Rails 8 | Oluwadare Juwon",
    meta_description: "How Rails 8 with Hotwire, Solid Queue, and Tailwind CSS made my portfolio faster and easier to maintain than my old React setup."
  },
  {
    title: "Building an AI-Powered Resume Builder: Lessons from RezumFit",
    slug: "building-rezumfit-ai-resume-builder",
    excerpt: "The story behind RezumFit — from idea to production. How I integrated OpenAI's API into a Rails application to create smart, ATS-optimized resumes.",
    status: "published",
    published_at: 1.week.ago,
    featured: false,
    reading_time: 12,
    category: ai_cat,
    meta_title: "Building an AI Resume Builder with Rails and OpenAI",
    meta_description: "How I built RezumFit, an AI-powered resume builder using Ruby on Rails and OpenAI's GPT API."
  },
  {
    title: "From Nigeria to the World: My Software Engineering Journey",
    slug: "my-software-engineering-journey",
    excerpt: "Six years of coding, 164+ GitHub repos, and countless lessons. Here's my story as a self-taught developer from Nigeria building for the global market.",
    status: "published",
    published_at: 2.weeks.ago,
    featured: false,
    reading_time: 10,
    category: career_cat,
    meta_title: "My Software Engineering Journey | Oluwadare Juwon",
    meta_description: "From learning to code in Nigeria to building AI-powered products — my 6-year journey as a software engineer."
  }
]

posts_data.each do |attrs|
  Post.find_or_create_by!(slug: attrs[:slug]) do |p|
    p.assign_attributes(attrs)
  end
end
puts "  Posts: #{Post.count} created"

# ──────────────────────────────────────────────
# Testimonials
# ──────────────────────────────────────────────
testimonials_data = [
  {
    author_name: "Alex Thompson",
    author_title: "Product Manager",
    company: "TechVentures Inc.",
    content: "Juwon is an exceptional developer who delivered our platform ahead of schedule. His expertise in Rails and attention to detail made the entire process seamless. Highly recommended!",
    rating: 5,
    featured: true,
    position: 1,
    relationship: "client"
  },
  {
    author_name: "Sarah Chen",
    author_title: "CTO",
    company: "StartupGrid",
    content: "Working with Juwon was a great experience. He built a robust API backend that handles thousands of requests without breaking a sweat. His code is clean, well-tested, and production-ready.",
    rating: 5,
    featured: true,
    position: 2,
    relationship: "client"
  },
  {
    author_name: "Michael Okonkwo",
    author_title: "Senior Developer",
    company: "DevHub Africa",
    content: "Juwon's knowledge of Ruby on Rails is impressive. He contributed significantly to our open-source projects and was always willing to mentor junior developers on the team.",
    rating: 5,
    featured: true,
    position: 3,
    relationship: "colleague"
  }
]

testimonials_data.each do |attrs|
  Testimonial.find_or_create_by!(author_name: attrs[:author_name]) do |t|
    t.assign_attributes(attrs)
  end
end
puts "  Testimonials: #{Testimonial.count} created"

puts "\nSeeding complete!"
puts "  Login: admin@wintan.dev / password123"
