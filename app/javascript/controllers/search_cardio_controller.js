import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-cardio"
export default class extends Controller {
  static targets = ["form", "input", "list"]
  connect() {
    console.log("connecté au controlleur search")
    console.log(this.formTarget)
    console.log(this.inputTarget)
    console.log(this.listTarget)
  }
  update(event) {
    event.preventDefault()
    console.log('update');
    const url = `${this.formTarget.action}?place=${this.inputTarget.value}`;
    console.log(url)
    fetch(url, {headers: {"Accept": "text/plain"}})
      .then(response => response.text())
      .then((data) => {
        this.listTarget.outerHTML = data
      })
  }
}
