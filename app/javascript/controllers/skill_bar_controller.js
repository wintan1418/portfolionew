import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["bar"]
  static values = {
    width: { type: Number, default: 0 },
    duration: { type: Number, default: 1200 }
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
      { threshold: 0.3 }
    )

    this.observer.observe(this.element)
  }

  disconnect() {
    if (this.observer) this.observer.disconnect()
  }

  animate() {
    const targetWidth = this.widthValue
    const duration = this.durationValue
    const start = performance.now()

    if (this.hasBarTarget) {
      const bar = this.barTarget

      const step = (timestamp) => {
        const progress = Math.min((timestamp - start) / duration, 1)
        const eased = 1 - Math.pow(1 - progress, 3) // ease-out cubic
        const currentWidth = eased * targetWidth

        bar.style.width = `${currentWidth}%`

        if (progress < 1) {
          requestAnimationFrame(step)
        }
      }

      requestAnimationFrame(step)
    }
  }
}
