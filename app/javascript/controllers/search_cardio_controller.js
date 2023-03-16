import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-cardio"
export default class extends Controller {
  static targets = ["form", "input", "list", "pagenumber", "cardio", "mail"]

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

  // mailto(e){
  //   console.log(this.listTarget)
  //   console.log(JSON.parse(this.listTarget.value))

  //   // let cardiourl = "https://www.doctolib.fr/cardiologue/lyon/#{cardiologist["Prénom d'exercice"]}.downcase %>-<%= cardiologist["Nom d'exercice"].downcase %>" 
  //   // for (const child of this.listTarget.children) {
  //   //   for(const cardio of child.children) {
  //   //     console.log(cardio['cardiourl']);
  //   //   }
  //   // }
  //   // window.open('mailto:'+this.mailTarget.value+'?subject=Your general practicioner send you the list of cardiologists near you&body=<b>'+html+'</b>');
  // }
}
