import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "panel"]
  static values = { active: { type: String, default: "" } }

  connect() {
    if (this.activeValue) {
      this.select(this.activeValue)
    } else if (this.tabTargets.length > 0) {
      this.select(this.tabTargets[0].dataset.tab)
    }
  }

  switch(event) {
    event.preventDefault()
    this.select(event.currentTarget.dataset.tab)
  }

  select(tabName) {
    this.tabTargets.forEach(tab => {
      const isActive = tab.dataset.tab === tabName
      tab.classList.toggle("text-white", isActive)
      tab.classList.toggle("bg-primary-600/20", isActive)
      tab.classList.toggle("border-primary-500", isActive)
      tab.classList.toggle("text-surface-400", !isActive)
      tab.classList.toggle("border-transparent", !isActive)
    })

    this.panelTargets.forEach(panel => {
      panel.classList.toggle("hidden", panel.dataset.tab !== tabName)
    })
  }
}
