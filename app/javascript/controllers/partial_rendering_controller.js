import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="partial-rendering"
export default class extends Controller {
  static targets = ["results", "enveloppe"]

  connect() {
    console.log("coucou partiel rendering");
  }

  show() {
    this.enveloppeTarget.classList.remove("d-none");
  }

}
