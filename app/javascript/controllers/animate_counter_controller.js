import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["number"]
  static values = {
    target: { type: Number, default: 0 },
    duration: { type: Number, default: 2000 },
    suffix: { type: String, default: "" }
  }

  connect() {
    this.observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            this.animate()
            this.observer.unobserve(entry.target)
          }
        })
      },
      { threshold: 0.5 }
    )

    this.observer.observe(this.element)
  }

  disconnect() {
    if (this.observer) this.observer.disconnect()
  }

  animate() {
    const target = this.targetValue
    const duration = this.durationValue
    const suffix = this.suffixValue
    const start = performance.now()

    const step = (timestamp) => {
      const progress = Math.min((timestamp - start) / duration, 1)
      const eased = 1 - Math.pow(1 - progress, 3) // ease-out cubic
      const current = Math.floor(eased * target)

      if (this.hasNumberTarget) {
        this.numberTarget.textContent = current + suffix
      }

      if (progress < 1) {
        requestAnimationFrame(step)
      }
    }

    requestAnimationFrame(step)
  }
}
