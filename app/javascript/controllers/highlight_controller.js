import { Controller } from "@hotwired/stimulus"

// Highlights code blocks in the article body using highlight.js loaded from CDN
export default class extends Controller {
  connect() {
    this.loadHighlightJS()
  }

  async loadHighlightJS() {
    // Skip if already loaded
    if (window.hljs) {
      this.highlightAll()
      return
    }

    // Load CSS
    if (!document.querySelector('link[href*="highlight.js"]')) {
      const link = document.createElement("link")
      link.rel = "stylesheet"
      link.href = "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/github-dark.min.css"
      document.head.appendChild(link)
    }

    // Load JS
    const script = document.createElement("script")
    script.src = "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js"
    script.onload = () => this.highlightAll()
    document.head.appendChild(script)
  }

  highlightAll() {
    this.element.querySelectorAll("pre code").forEach((block) => {
      window.hljs.highlightElement(block)
      this.addCopyButton(block.closest("pre"))
    })
  }

  addCopyButton(pre) {
    if (!pre || pre.querySelector(".copy-btn")) return

    const button = document.createElement("button")
    button.className = "copy-btn absolute top-2 right-2 px-2 py-1 rounded-md text-xs bg-surface-700 text-surface-300 hover:text-white hover:bg-surface-600 transition-colors opacity-0 group-hover:opacity-100"
    button.textContent = "Copy"
    button.addEventListener("click", () => this.copyCode(pre, button))

    pre.style.position = "relative"
    pre.classList.add("group")
    pre.appendChild(button)
  }

  async copyCode(pre, button) {
    const code = pre.querySelector("code")
    if (!code) return

    try {
      await navigator.clipboard.writeText(code.textContent)
      button.textContent = "Copied!"
      setTimeout(() => { button.textContent = "Copy" }, 2000)
    } catch {
      button.textContent = "Failed"
      setTimeout(() => { button.textContent = "Copy" }, 2000)
    }
  }
}
