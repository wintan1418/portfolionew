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
    active = current_page?(path)
    link_to label, path, class: [
      "px-3.5 py-1.5 rounded-lg text-sm transition-all duration-200",
      active ? "text-white font-medium bg-surface-800/60" : "text-surface-400 hover:text-white hover:bg-surface-800/30"
    ].join(" ")
  end

  def mobile_nav_link(label, path)
    active = current_page?(path)
    link_to label, path, class: [
      "flex items-center gap-3 px-4 py-3 rounded-xl text-sm transition-all duration-200",
      active ? "text-white bg-surface-800/60 font-medium" : "text-surface-400 hover:text-white hover:bg-surface-800/30"
    ].join(" ")
  end

  def admin_nav_link(label, path, icon_path)
    active = current_page?(path)
    link_to path, class: [
      "flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium transition-colors",
      active ? "text-white bg-primary-600/20 text-primary-300" : "text-surface-400 hover:text-white hover:bg-surface-800"
    ].join(" ") do
      content_tag(:svg, content_tag(:path, nil, d: icon_path, "stroke-linecap": "round", "stroke-linejoin": "round", "stroke-width": "2"),
        class: "w-4 h-4 shrink-0", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor") +
      content_tag(:span, label)
    end
  end

  def command_palette_item(label, path, icon_path)
    link_to path, class: "flex items-center gap-3 px-3 py-2.5 rounded-xl text-sm text-surface-400 hover:text-white hover:bg-surface-900 transition-colors command-palette-item", data: { label: label.downcase } do
      content_tag(:svg, content_tag(:path, nil, d: icon_path, "stroke-linecap": "round", "stroke-linejoin": "round", "stroke-width": "1.5"),
        class: "w-4 h-4 shrink-0 text-surface-600", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor") +
      content_tag(:span, label)
    end
  end

  def json_ld_tag(data)
    content_tag(:script, data.to_json.html_safe, type: "application/ld+json")
  end
end
