import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    maxTilt: { type: Number, default: 8 },
    perspective: { type: Number, default: 1000 },
    scale: { type: Number, default: 1.02 }
  }

  connect() {
    this.moveHandler = this.onMove.bind(this)
    this.leaveHandler = this.onLeave.bind(this)
    this.element.addEventListener("mousemove", this.moveHandler)
    this.element.addEventListener("mouseleave", this.leaveHandler)
  }

  disconnect() {
    this.element.removeEventListener("mousemove", this.moveHandler)
    this.element.removeEventListener("mouseleave", this.leaveHandler)
  }

  onMove(e) {
    const rect = this.element.getBoundingClientRect()
    const x = e.clientX - rect.left
    const y = e.clientY - rect.top
    const centerX = rect.width / 2
    const centerY = rect.height / 2

    const rotateX = ((y - centerY) / centerY) * -this.maxTiltValue
    const rotateY = ((x - centerX) / centerX) * this.maxTiltValue

    this.element.style.transform = `perspective(${this.perspectiveValue}px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) scale(${this.scaleValue})`
    this.element.style.transition = "transform 0.1s ease-out"
  }

  onLeave() {
    this.element.style.transform = "perspective(1000px) rotateX(0deg) rotateY(0deg) scale(1)"
    this.element.style.transition = "transform 0.4s ease-out"
  }
}
