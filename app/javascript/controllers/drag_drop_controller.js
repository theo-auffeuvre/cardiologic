import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="drag-drop"
export default class extends Controller {
    static targets = [ 'input','zone' ]

    connect(){
      console.log("controller drag-drop connecté !");
    }

    drop(event) {
        event.preventDefault();
        this.inputTarget.files = event.dataTransfer.files;
        this.zoneTarget.innerText = event.dataTransfer.files[0].name;
      }

      dragover(event) {
        this.zoneTarget.classList.add('hover');
        event.preventDefault();

      }

      dragleave(event) {
        this.zoneTarget.classList.remove('hover');
        event.preventDefault();
      }
  }
