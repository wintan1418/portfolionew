import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo-transitions"
// Provides smooth page transitions using the View Transitions API.
// Falls back gracefully when the browser does not support it.
export default class extends Controller {
  connect() {
    this.supportsViewTransitions = typeof document.startViewTransition === "function"

    if (!this.supportsViewTransitions) return

    this.handleBeforeRender = this.#beforeRender.bind(this)
    this.handleRender = this.#render.bind(this)

    document.addEventListener("turbo:before-render", this.handleBeforeRender)
    document.addEventListener("turbo:render", this.handleRender)
  }

  disconnect() {
    if (!this.supportsViewTransitions) return

    document.removeEventListener("turbo:before-render", this.handleBeforeRender)
    document.removeEventListener("turbo:render", this.handleRender)
  }

  // Intercept Turbo's render phase and wrap it in a View Transition.
  // We pause Turbo's default render by calling event.preventDefault(),
  // then resume it inside startViewTransition so the browser can
  // animate the old and new snapshots.
  #beforeRender(event) {
    event.preventDefault()

    const resume = event.detail.resume

    document.startViewTransition(() => {
      resume()

      // Return a promise that resolves after the new page is rendered,
      // giving the transition API time to capture the new state.
      return new Promise((resolve) => {
        document.addEventListener("turbo:render", () => resolve(), { once: true })
      })
    })
  }

  // Optional hook for post-render work (e.g. re-triggering scroll-reveal
  // animations on the freshly rendered page).
  #render(_event) {
    // Dispatch a custom event that other controllers can listen for
    this.element.dispatchEvent(
      new CustomEvent("turbo-transitions:rendered", { bubbles: true })
    )
  }
}
