import { Controller } from "@hotwired/stimulus"
import { gsap } from "gsap"
import { ScrollTrigger } from "gsap/ScrollTrigger"

gsap.registerPlugin(ScrollTrigger)

// Elements inside drift at different speeds while scrolling.
//   <div data-controller="parallax"><img data-parallax-speed="-0.2"></div>
export default class extends Controller {
  connect() {
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return
    this.tweens = Array.from(this.element.querySelectorAll("[data-parallax-speed]")).map((el) => {
      const speed = parseFloat(el.dataset.parallaxSpeed || 0.2)
      return gsap.to(el, {
        yPercent: speed * 100,
        ease: "none",
        scrollTrigger: { trigger: this.element, start: "top bottom", end: "bottom top", scrub: true }
      })
    })
  }

  disconnect() {
    this.tweens?.forEach((t) => { t.scrollTrigger?.kill(); t.kill() })
  }
}
