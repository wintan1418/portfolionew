module ApplicationHelper
  include Pagy::Frontend

  def nav_link(label, path)
    active = current_page?(path)
    link_to label, path, class: [
      "text-sm transition-colors relative",
      active ? "text-white font-medium" : "text-surface-500 hover:text-white"
    ].join(" ")
  end

  def nav_link_pill(label, path)
    active = current_page?(path) || (path != root_path && request.path.start_with?(path))
    link_to label, path, class: [ "nav-link", ("is-active" if active) ].compact.join(" ")
  end

  # Maps a skill name to a bundled brand icon (app/assets/images/tech/*.svg).
  TECH_ICONS = {
    "ruby on rails" => "rubyonrails", "rails" => "rubyonrails", "ruby" => "ruby", "react" => "react",
    "postgresql" => "postgresql", "postgres" => "postgresql", "docker" => "docker", "aws" => "amazonwebservices",
    "typescript" => "typescript", "javascript" => "javascript", "javascript/es6+" => "javascript",
    "tailwind css" => "tailwindcss", "tailwind" => "tailwindcss", "hotwire" => "hotwire", "hotwire (turbo + stimulus)" => "hotwire",
    "hotwire native" => "hotwire", "turbo" => "turbo", "redis" => "redis", "python" => "python", "node.js" => "nodedotjs", "node" => "nodedotjs",
    "graphql" => "graphql", "kotlin" => "kotlin", "git" => "git", "git/github" => "github", "github" => "github", "stripe" => "stripe",
    "nginx" => "nginx", "linux" => "linux", "linux/ubuntu" => "linux", "heroku" => "heroku", "openai" => "openai", "openai api" => "openai",
    "vue.js" => "vuedotjs", "vue" => "vuedotjs", "mongodb" => "mongodb", "elasticsearch" => "elasticsearch", "html/css" => "html5", "html" => "html5",
    "sidekiq" => "sidekiq", "next.js" => "nextdotjs", "android" => "androidstudio"
  }.freeze

  # Official brand colours (simple-icons data).
  TECH_COLORS = {
    "amazonwebservices" => "#232F3E",
    "androidstudio" => "#3DDC84",
    "docker" => "#2496ED",
    "elasticsearch" => "#005571",
    "git" => "#F05032",
    "github" => "#181717",
    "graphql" => "#E10098",
    "heroku" => "#430098",
    "hotwire" => "#FFE801",
    "html5" => "#E34F26",
    "javascript" => "#F7DF1E",
    "kotlin" => "#7F52FF",
    "linux" => "#FCC624",
    "mongodb" => "#47A248",
    "nextdotjs" => "#000000",
    "nginx" => "#009639",
    "nodedotjs" => "#5FA04E",
    "openai" => "#412991",
    "postgresql" => "#4169E1",
    "python" => "#3776AB",
    "react" => "#61DAFB",
    "redis" => "#FF4438",
    "ruby" => "#CC342D",
    "rubyonrails" => "#D30001",
    "sidekiq" => "#B1003E",
    "stripe" => "#008CDD",
    "tailwindcss" => "#06B6D4",
    "turbo" => "#5CD8E5",
    "typescript" => "#3178C6",
    "vuedotjs" => "#4FC08D"
  }.freeze

  def tech_icon(name, css: "w-7 h-7")
    slug = TECH_ICONS[name.to_s.strip.downcase]
    return unless slug && Rails.root.join("app/assets/images/tech/#{slug}.svg").exist?

    hex = TECH_COLORS[slug]&.delete("#")
    style = nil
    if hex
      r, g, b = hex.scan(/../).map { |c| c.to_i(16) }
      style = "--brand: ##{hex}"
      style += "; --brand-dark: #e8ebf2" if [ r, g, b ].max < 80 # near-black logos get a light fallback in dark mode
    end
    inline_svg_tag("tech/#{slug}.svg", class: css, aria_hidden: true, style: style)
  end

  def mobile_nav_link(label, path)
    active = current_page?(path) || (path != root_path && request.path.start_with?(path))
    link_to label, path, data: { action: "navbar#closeMobile" }, class: [
      "flex items-center px-4 py-3 rounded-xl text-base transition-colors",
      active ? "text-ink font-medium" : "text-ink-2 hover:text-ink"
    ].join(" ")
  end

  def admin_nav_link(label, path, icon_path)
    active = current_page?(path) || (path != admin_root_path && request.path.start_with?(path))
    link_to path, class: [
      "admin-nav-link flex items-center gap-3 px-3 py-2 rounded-xl text-sm transition-colors",
      active ? "is-active" : ""
    ].join(" ") do
      content_tag(:svg, content_tag(:path, nil, d: icon_path, "stroke-linecap": "round", "stroke-linejoin": "round", "stroke-width": "1.6"),
        class: "w-4 h-4 shrink-0", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor") +
      content_tag(:span, label)
    end
  end

  def command_palette_item(label, path, icon_path)
    link_to path, class: "flex items-center gap-3 px-3 py-2.5 rounded-xl text-sm text-ink-2 hover:text-ink hover:bg-white/5 transition-colors command-palette-item", data: { label: label.downcase } do
      content_tag(:svg, content_tag(:path, nil, d: icon_path, "stroke-linecap": "round", "stroke-linejoin": "round", "stroke-width": "1.5"),
        class: "w-4 h-4 shrink-0 text-ink-3", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor") +
      content_tag(:span, label)
    end
  end

  def json_ld_tag(data)
    content_tag(:script, data.to_json.html_safe, type: "application/ld+json")
  end
end
