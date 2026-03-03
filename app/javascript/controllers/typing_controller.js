import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["output"]
  static values = {
    strings: { type: Array, default: ["Developer"] },
    typeSpeed: { type: Number, default: 80 },
    backSpeed: { type: Number, default: 40 },
    pause: { type: Number, default: 2000 }
  }

  connect() {
    this.stringIndex = 0
    this.charIndex = 0
    this.isDeleting = false
    this.type()
  }

  disconnect() {
    if (this.timeout) clearTimeout(this.timeout)
  }

  type() {
    const current = this.stringsValue[this.stringIndex]
    if (!current) return

    if (this.isDeleting) {
      this.charIndex--
      this.outputTarget.textContent = current.substring(0, this.charIndex)
    } else {
      this.charIndex++
      this.outputTarget.textContent = current.substring(0, this.charIndex)
    }

    let delay = this.isDeleting ? this.backSpeedValue : this.typeSpeedValue

    if (!this.isDeleting && this.charIndex === current.length) {
      delay = this.pauseValue
      this.isDeleting = true
    } else if (this.isDeleting && this.charIndex === 0) {
      this.isDeleting = false
      this.stringIndex = (this.stringIndex + 1) % this.stringsValue.length
      delay = 500
    }

    this.timeout = setTimeout(() => this.type(), delay)
  }
}
