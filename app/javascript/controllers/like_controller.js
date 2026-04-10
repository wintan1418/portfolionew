import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["icon", "count"]

  toggle(event) {
    const icon = this.iconTarget
    icon.classList.add("scale-125")
    setTimeout(() => icon.classList.remove("scale-125"), 200)
  }
}
