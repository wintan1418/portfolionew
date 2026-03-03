import { Controller } from "@hotwired/stimulus"

// Generic clipboard copy controller for any element
// Usage: <button data-controller="clipboard" data-clipboard-text-value="text to copy">Copy</button>
export default class extends Controller {
  static values = { text: String }

  async copy() {
    try {
      await navigator.clipboard.writeText(this.textValue)
      const original = this.element.textContent
      this.element.textContent = "Copied!"
      setTimeout(() => { this.element.textContent = original }, 2000)
    } catch {
      // Fallback for older browsers
      const textarea = document.createElement("textarea")
      textarea.value = this.textValue
      textarea.style.position = "fixed"
      textarea.style.opacity = "0"
      document.body.appendChild(textarea)
      textarea.select()
      document.execCommand("copy")
      document.body.removeChild(textarea)

      const original = this.element.textContent
      this.element.textContent = "Copied!"
      setTimeout(() => { this.element.textContent = original }, 2000)
    }
  }
}
