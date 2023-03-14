import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-cardio"
export default class extends Controller {
  static targets = ["form", "input", "list", "pagenumber", "cardio"]

  static values = {
    url: String
  }

  connect() {
    console.log("connecté au controlleur search")
    console.log(this.formTarget)
    console.log(this.inputTarget)
    console.log(this.listTarget)
  }
  update(event) {
    event.preventDefault()
    console.log("update")
    const url = `${this.formTarget.action}?place=${this.inputTarget.value}`;
    fetch(url, {headers: {"Accept": "text/plain"}})
      .then(response => response.text())
      .then((data) => {
        this.listTarget.outerHTML = data
      })
  }

  selectcardio(e){
    console.log(e.currentTarget.dataset.searchCardioUrlValue.replace(/ /g, "-"))
  }
}
