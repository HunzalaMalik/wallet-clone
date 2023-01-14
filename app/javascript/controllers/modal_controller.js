import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]

  open() {
    this.modalTarget.classList.add("is-open")
  }

  close() {
    this.modalTarget.classList.remove("is-open")
  }
}
