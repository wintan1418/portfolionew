import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dialog", "input", "results"]

  connect() {
    this.keyHandler = this.onKeydown.bind(this)
    document.addEventListener("keydown", this.keyHandler)
  }

  disconnect() {
    document.removeEventListener("keydown", this.keyHandler)
  }

  onKeydown(event) {
    if ((event.metaKey || event.ctrlKey) && event.key === "k") {
      event.preventDefault()
      this.open()
    }
    if (event.key === "Escape" && this.hasDialogTarget && this.dialogTarget.open) {
      this.close()
    }
  }

  open() {
    if (!this.hasDialogTarget) return
    this.dialogTarget.showModal()
    if (this.hasInputTarget) {
      this.inputTarget.value = ""
      this.inputTarget.focus()
      this.showAll()
    }
  }

  close() {
    if (!this.hasDialogTarget) return
    this.dialogTarget.close()
  }

  closeOnBackdrop(event) {
    if (event.target === event.currentTarget) {
      this.close()
    }
  }

  search() {
    if (!this.hasInputTarget || !this.hasResultsTarget) return
    const query = this.inputTarget.value.toLowerCase().trim()

    this.resultsTarget.querySelectorAll(".command-palette-item").forEach((item) => {
      const label = item.dataset.label || item.textContent.toLowerCase()
      item.style.display = query === "" || label.includes(query) ? "" : "none"
    })
  }

  navigate(event) {
    const items = [...this.resultsTarget.querySelectorAll(".command-palette-item")]
      .filter((el) => el.style.display !== "none")

    if (event.key === "Enter" && items.length > 0) {
      event.preventDefault()
      items[0].click()
      this.close()
    }
  }

  showAll() {
    if (!this.hasResultsTarget) return
    this.resultsTarget.querySelectorAll(".command-palette-item").forEach((item) => {
      item.style.display = ""
    })
  }
}
