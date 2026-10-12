import { Controller } from "@hotwired/stimulus"
import { gsap } from "gsap"

// Buttons that gently pull toward the cursor.
export default class extends Controller {
  static values = { strength: { type: Number, default: 0.35 } }

  connect() {
    if (window.matchMedia("(hover: none)").matches) return
    this.onMove = this.#move.bind(this)
    this.onLeave = this.#leave.bind(this)
    this.element.addEventListener("pointermove", this.onMove)
    this.element.addEventListener("pointerleave", this.onLeave)
  }

  disconnect() {
    this.element.removeEventListener("pointermove", this.onMove)
    this.element.removeEventListener("pointerleave", this.onLeave)
  }

  #move(e) {
    const r = this.element.getBoundingClientRect()
    const x = (e.clientX - (r.left + r.width / 2)) * this.strengthValue
    const y = (e.clientY - (r.top + r.height / 2)) * this.strengthValue
    gsap.to(this.element, { x, y, duration: 0.5, ease: "power3.out" })
  }

  #leave() {
    gsap.to(this.element, { x: 0, y: 0, duration: 0.8, ease: "elastic.out(1, 0.45)" })
  }
}
