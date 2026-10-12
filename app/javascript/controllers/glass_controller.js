import { Controller } from "@hotwired/stimulus"

// Attach once on <body>. Tracks the pointer and feeds --mx/--my to every
// .glass surface under the cursor so the sheen and edge light follow it.
export default class extends Controller {
  connect() {
    this.onMove = this.#move.bind(this)
    this.onLeave = this.#leave.bind(this)
    this.lit = null
    document.addEventListener("pointermove", this.onMove, { passive: true })
    document.addEventListener("pointerleave", this.onLeave)
  }

  disconnect() {
    document.removeEventListener("pointermove", this.onMove)
    document.removeEventListener("pointerleave", this.onLeave)
  }

  #move(event) {
    const el = event.target.closest?.(".glass")
    if (this.lit && this.lit !== el) {
      this.lit.classList.remove("is-lit")
      this.lit = null
    }
    if (!el) return
    const rect = el.getBoundingClientRect()
    el.style.setProperty("--mx", `${event.clientX - rect.left}px`)
    el.style.setProperty("--my", `${event.clientY - rect.top}px`)
    if (this.lit !== el) {
      el.classList.add("is-lit")
      this.lit = el
    }
  }

  #leave() {
    if (this.lit) this.lit.classList.remove("is-lit")
    this.lit = null
  }
}
