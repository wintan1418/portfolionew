import { Controller } from "@hotwired/stimulus"
import { gsap } from "gsap"

// Choreographed intro for the hero. Elements opt in with data-hero="n"
// (order) and optional data-hero-kind="words|up|scale|fade".
export default class extends Controller {
  connect() {
    const reduced = window.matchMedia("(prefers-reduced-motion: reduce)").matches
    const items = Array.from(this.element.querySelectorAll("[data-hero]"))
      .sort((a, b) => parseFloat(a.dataset.hero) - parseFloat(b.dataset.hero))

    if (reduced || items.length === 0) {
      items.forEach((el) => (el.style.opacity = 1))
      return
    }

    this.tl = gsap.timeline({ defaults: { ease: "expo.out", duration: 1.2 } })
    items.forEach((el, i) => {
      const kind = el.dataset.heroKind || "up"
      const at = 0.1 + i * 0.12
      if (kind === "words") {
        const words = this.#splitWords(el)
        gsap.set(el, { opacity: 1 })
        gsap.set(words, { yPercent: 110, rotateX: -50, opacity: 0 })
        this.tl.to(words, { yPercent: 0, rotateX: 0, opacity: 1, stagger: 0.05 }, at)
      } else if (kind === "scale") {
        gsap.set(el, { opacity: 0, scale: 0.9, y: 30 })
        this.tl.to(el, { opacity: 1, scale: 1, y: 0, duration: 1.5 }, at)
      } else if (kind === "fade") {
        gsap.set(el, { opacity: 0 })
        this.tl.to(el, { opacity: 1 }, at)
      } else {
        gsap.set(el, { opacity: 0, y: 32 })
        this.tl.to(el, { opacity: 1, y: 0 }, at)
      }
    })
  }

  disconnect() {
    this.tl?.kill()
  }

  #splitWords(el) {
    const out = []
    const wrapElement = (el) => {
      const outer = document.createElement("span")
      outer.style.cssText = "display:inline-block;overflow:hidden;vertical-align:top;padding-bottom:0.1em;margin-bottom:-0.1em;perspective:600px"
      el.replaceWith(outer)
      el.style.display = "inline-block"
      el.style.transformOrigin = "50% 100%"
      outer.appendChild(el)
      out.push(el)
    }
    const walk = (node) => {
      Array.from(node.childNodes).forEach((child) => {
        if (child.nodeType === Node.TEXT_NODE) {
          const frag = document.createDocumentFragment()
          child.textContent.split(/(\s+)/).forEach((w) => {
            if (!w) return
            if (/^\s+$/.test(w)) return frag.appendChild(document.createTextNode(" "))
            const outer = document.createElement("span")
            outer.style.cssText = "display:inline-block;overflow:hidden;vertical-align:top;padding-bottom:0.1em;margin-bottom:-0.1em;perspective:600px"
            const inner = document.createElement("span")
            inner.style.cssText = "display:inline-block;transform-origin:50% 100%"
            inner.textContent = w
            outer.appendChild(inner)
            frag.appendChild(outer)
            out.push(inner)
          })
          child.replaceWith(frag)
        } else if (child.nodeType === Node.ELEMENT_NODE && child.tagName !== "BR") {
          if (child.classList.contains("gradient-text") || child.classList.contains("serif-accent") || child.dataset.splitUnit !== undefined) {
            wrapElement(child)
          } else {
            walk(child)
          }
        }
      })
    }
    walk(el)
    return out
  }
}
