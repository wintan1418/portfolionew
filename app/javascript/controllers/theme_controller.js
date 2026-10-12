import { Controller } from "@hotwired/stimulus"

// Theme lives on <html class="dark|light">. Dark is the default.
export default class extends Controller {
  connect() {
    this.apply(localStorage.getItem("theme") || "dark")
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
