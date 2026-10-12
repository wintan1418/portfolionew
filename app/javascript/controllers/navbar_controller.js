import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mobileMenu", "hamburgerIcon", "closeIcon"]

  connect() {
    this.isOpen = false
    this.onScroll = this.#scroll.bind(this)
    window.addEventListener("scroll", this.onScroll, { passive: true })
    this.#scroll()
  }

  disconnect() {
    window.removeEventListener("scroll", this.onScroll)
    document.body.style.overflow = ""
  }

  #scroll() {
    this.element.classList.toggle("nav-scrolled", window.scrollY > 24)
  }

  toggleMobile() {
    this.isOpen = !this.isOpen
    this.mobileMenuTarget.classList.toggle("hidden", !this.isOpen)
    this.hamburgerIconTarget.classList.toggle("hidden", this.isOpen)
    this.closeIconTarget.classList.toggle("hidden", !this.isOpen)
    document.body.style.overflow = this.isOpen ? "hidden" : ""
  }

  closeMobile() {
    if (this.isOpen) this.toggleMobile()
  }
}
