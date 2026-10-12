import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.onScroll = this.#update.bind(this)
    window.addEventListener("scroll", this.onScroll, { passive: true })
    this.#update()
  }

  disconnect() {
    window.removeEventListener("scroll", this.onScroll)
  }

  #update() {
    const max = document.documentElement.scrollHeight - window.innerHeight
    const p = max > 0 ? Math.min(window.scrollY / max, 1) : 0
    this.element.style.transform = `scaleX(${p})`
  }
}
