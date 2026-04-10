import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "parentId"]

  reply(event) {
    event.preventDefault()
    const commentId = event.currentTarget.dataset.commentId
    const authorName = event.currentTarget.dataset.authorName
    this.parentIdTarget.value = commentId
    this.formTarget.scrollIntoView({ behavior: "smooth", block: "center" })

    const bodyField = this.formTarget.querySelector("textarea")
    if (bodyField) {
      bodyField.placeholder = `Reply to ${authorName}...`
      bodyField.focus()
    }

    this.showCancelButton()
  }

  cancelReply(event) {
    event.preventDefault()
    this.parentIdTarget.value = ""
    const bodyField = this.formTarget.querySelector("textarea")
    if (bodyField) {
      bodyField.placeholder = "Share your thoughts..."
    }
    this.hideCancelButton()
  }

  showCancelButton() {
    const btn = this.formTarget.querySelector("[data-cancel-reply]")
    if (btn) btn.classList.remove("hidden")
  }

  hideCancelButton() {
    const btn = this.formTarget.querySelector("[data-cancel-reply]")
    if (btn) btn.classList.add("hidden")
  }
}
