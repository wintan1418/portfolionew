import { Controller } from "@hotwired/stimulus"
import { gsap } from "gsap"
import { ScrollTrigger } from "gsap/ScrollTrigger"

gsap.registerPlugin(ScrollTrigger)

// Scroll-driven entrance animations.
//
//   <section data-controller="reveal">
//     <h2 data-reveal="words">Split and staggered by word</h2>
//     <p data-reveal="up" data-reveal-delay="0.1">…</p>
//     <div data-reveal="stagger">children fade in one after another</div>
//   </section>
export default class extends Controller {
  connect() {
    this.tweens = []
    this.reduced = window.matchMedia("(prefers-reduced-motion: reduce)").matches
    this.element.querySelectorAll("[data-reveal]").forEach((el) => this.#animate(el))
  }

  disconnect() {
    this.tweens.forEach((t) => {
      t.scrollTrigger?.kill()
      t.kill()
    })
    this.tweens = []
  }

  #animate(el) {
    const kind = el.dataset.reveal || "up"
    const delay = parseFloat(el.dataset.revealDelay || 0)

    if (this.reduced) {
      el.classList.add("is-visible")
      return
    }

    const trigger = {
      trigger: el,
      start: "top 88%",
      once: true,
      onEnter: () => el.classList.add("is-visible")
    }

    if (kind === "words" || kind === "lines") {
      const parts = this.#split(el, kind)
      el.classList.add("is-visible")
      gsap.set(parts, { yPercent: 110, opacity: 0, rotateX: kind === "words" ? -40 : 0 })
      this.tweens.push(
        gsap.to(parts, {
          yPercent: 0, opacity: 1, rotateX: 0,
          duration: 1, ease: "expo.out",
          stagger: kind === "words" ? 0.045 : 0.12, delay,
          scrollTrigger: trigger
        })
      )
      return
    }

    if (kind === "stagger") {
      const children = Array.from(el.children)
      el.classList.add("is-visible")
      gsap.set(children, { y: 30, opacity: 0 })
      this.tweens.push(
        gsap.to(children, { y: 0, opacity: 1, duration: 0.8, ease: "expo.out", stagger: 0.06, delay, scrollTrigger: trigger })
      )
      return
    }

    const from = {
      up: { y: 36, opacity: 0 },
      down: { y: -40, opacity: 0 },
      left: { x: -48, opacity: 0 },
      right: { x: 48, opacity: 0 },
      scale: { scale: 0.92, opacity: 0 },
      fade: { opacity: 0 },
      blur: { opacity: 0, filter: "blur(14px)", y: 20 }
    }[kind] || { y: 36, opacity: 0 }

    gsap.set(el, from)
    this.tweens.push(
      gsap.to(el, {
        x: 0, y: 0, scale: 1, opacity: 1, filter: "blur(0px)",
        duration: 0.8, ease: "expo.out", delay,
        clearProps: "filter",
        scrollTrigger: trigger
      })
    )
  }

  // Wrap each word (or each line, approximated by <br>/block children) in a
  // masked span so it can slide up into view.
  #split(el, kind) {
    if (el.dataset.split === "done") return Array.from(el.querySelectorAll(".split-inner"))
    const nodes = []
    const wrap = (text) => {
      const outer = document.createElement("span")
      outer.className = "split-outer"
      outer.style.cssText = "display:inline-block;overflow:hidden;vertical-align:top;padding-bottom:0.08em;margin-bottom:-0.08em"
      const inner = document.createElement("span")
      inner.className = "split-inner"
      inner.style.cssText = "display:inline-block;will-change:transform"
      inner.textContent = text
      outer.appendChild(inner)
      nodes.push(inner)
      return outer
    }
    const wrapElement = (el) => {
      const outer = document.createElement("span")
      outer.className = "split-outer"
      outer.style.cssText = "display:inline-block;overflow:hidden;vertical-align:top;padding-bottom:0.08em;margin-bottom:-0.08em"
      el.replaceWith(outer)
      el.classList.add("split-inner")
      el.style.display = "inline-block"
      el.style.willChange = "transform"
      outer.appendChild(el)
      nodes.push(el)
    }
    const walk = (node) => {
      Array.from(node.childNodes).forEach((child) => {
        if (child.nodeType === Node.TEXT_NODE) {
          const frag = document.createDocumentFragment()
          const words = child.textContent.split(/(\s+)/)
          words.forEach((w) => {
            if (!w) return
            if (/^\s+$/.test(w)) frag.appendChild(document.createTextNode(" "))
            else frag.appendChild(wrap(w))
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
    el.dataset.split = "done"
    return nodes
  }
}
