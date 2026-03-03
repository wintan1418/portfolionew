import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["nav", "mobileMenu", "menuButton", "hamburgerIcon", "closeIcon"]

  connect() {
    this.isOpen = false
    this.scrollHandler = this.onScroll.bind(this)
    window.addEventListener("scroll", this.scrollHandler, { passive: true })
    this.onScroll()
  }

  disconnect() {
    window.removeEventListener("scroll", this.scrollHandler)
  }

  onScroll() {
    if (!this.hasNavTarget) return
    const scrolled = window.scrollY > 20

    if (scrolled) {
      this.navTarget.classList.add("nav-scrolled")
      this.navTarget.classList.remove("nav-top")
    } else {
      this.navTarget.classList.remove("nav-scrolled")
      this.navTarget.classList.add("nav-top")
    }
  }

  toggleMobile() {
    if (!this.hasMobileMenuTarget) return
    this.isOpen = !this.isOpen

    if (this.isOpen) {
      this.mobileMenuTarget.style.maxHeight = this.mobileMenuTarget.scrollHeight + "px"
      this.mobileMenuTarget.style.opacity = "1"
    } else {
      this.mobileMenuTarget.style.maxHeight = "0"
      this.mobileMenuTarget.style.opacity = "0"
    }

    // Toggle hamburger / close icons
    if (this.hasHamburgerIconTarget && this.hasCloseIconTarget) {
      this.hamburgerIconTarget.classList.toggle("hidden", this.isOpen)
      this.closeIconTarget.classList.toggle("hidden", !this.isOpen)
    }
  }
}
