import { Controller } from "@hotwired/stimulus"

// Theme lives on <html class="dark|light">. A theme picked with the toggle
// wins; otherwise each page's default (body data-default-theme, dark for most
// pages, light for the blog) applies, also after Turbo navigations.
export default class extends Controller {
  connect() {
    this.sync = () => this.apply(this.preferred())
    document.addEventListener("turbo:load", this.sync)
    this.sync()
  }

  disconnect() {
    document.removeEventListener("turbo:load", this.sync)
  }

  preferred() {
    try {
      const saved = localStorage.getItem("theme")
      if (saved === "light" || saved === "dark") return saved
    } catch {}
    return document.body?.dataset.defaultTheme || "dark"
  }

  toggle() {
    const next = document.documentElement.classList.contains("dark") ? "light" : "dark"
    localStorage.setItem("theme", next)
    this.apply(next, true)
  }

  apply(theme, animate = false) {
    const html = document.documentElement
    const swap = () => {
      html.classList.remove("dark", "light")
      html.classList.add(theme)
      html.style.colorScheme = theme
      this.element.dispatchEvent(new CustomEvent("theme:changed", { bubbles: true, detail: { theme } }))
    }
    if (animate && typeof document.startViewTransition === "function") {
      document.startViewTransition(swap)
    } else {
      swap()
    }
  }
}
