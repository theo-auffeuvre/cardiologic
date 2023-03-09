import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toto"
export default class extends Controller {
  connect() {
    console.log("coucou stimulus");
  }
}
