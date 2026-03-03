import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle", "body"]

  connect() {
    this.applyTheme()
  }

  toggle() {
    const html = document.documentElement
    const isDark = html.classList.contains("dark")

    if (isDark) {
      html.classList.remove("dark")
      html.classList.add("light")
      localStorage.setItem("theme", "light")
    } else {
      html.classList.remove("light")
      html.classList.add("dark")
      localStorage.setItem("theme", "dark")
    }

    this.updateUI()
  }

  applyTheme() {
    const saved = localStorage.getItem("theme") || "dark"
    const html = document.documentElement

    html.classList.remove("dark", "light")
    html.classList.add(saved)
    this.updateUI()
  }

  updateUI() {
    const isDark = document.documentElement.classList.contains("dark")

    // Toggle icon visibility
    document.querySelectorAll(".dark-icon").forEach(el => el.classList.toggle("hidden", !isDark))
    document.querySelectorAll(".light-icon").forEach(el => el.classList.toggle("hidden", isDark))

    // Update body colors
    if (this.hasBodyTarget) {
      if (isDark) {
        this.bodyTarget.classList.add("bg-surface-950", "text-surface-200")
        this.bodyTarget.classList.remove("bg-white", "text-surface-800")
      } else {
        this.bodyTarget.classList.remove("bg-surface-950", "text-surface-200")
        this.bodyTarget.classList.add("bg-white", "text-surface-800")
      }
    }
  }
}
