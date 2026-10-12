import { Controller } from "@hotwired/stimulus"

// Gallery lightbox. Images inside with data-lightbox-src open full size.
export default class extends Controller {
  static targets = ["dialog", "image", "caption", "counter"]

  connect() {
    this.items = Array.from(this.element.querySelectorAll("[data-lightbox-src]"))
    this.index = 0
    this.onKey = this.#key.bind(this)
  }

  open(event) {
    event.preventDefault()
    this.index = this.items.indexOf(event.currentTarget)
    this.#show()
    this.dialogTarget.showModal()
    document.addEventListener("keydown", this.onKey)
  }

  close() {
    this.dialogTarget.close()
    document.removeEventListener("keydown", this.onKey)
  }

  closeOnBackdrop(event) {
    if (event.target === this.dialogTarget) this.close()
  }

  next() { this.index = (this.index + 1) % this.items.length; this.#show() }
  prev() { this.index = (this.index - 1 + this.items.length) % this.items.length; this.#show() }

  #show() {
    const el = this.items[this.index]
    this.imageTarget.src = el.dataset.lightboxSrc
    this.imageTarget.alt = el.dataset.lightboxCaption || ""
    if (this.hasCaptionTarget) this.captionTarget.textContent = el.dataset.lightboxCaption || ""
    if (this.hasCounterTarget) this.counterTarget.textContent = `${this.index + 1} / ${this.items.length}`
  }

  #key(e) {
    if (e.key === "ArrowRight") this.next()
    if (e.key === "ArrowLeft") this.prev()
  }
}
