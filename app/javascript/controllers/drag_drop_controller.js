import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="drag-drop"
export default class extends Controller {
    static targets = [ 'input','zone' ]

    connect(){
      console.log('b');
      console.log("controller drag-drop connecté !");
    }

    /**
     * On drop zone click, we trigger <input type="file"/> click
     * to open native file browser on client.
     */
    onDropZoneClick(event) {
      this.inputTarget.click();
    }

    /**
     * When file is selected by user in native file browser, input element
     * will emit 'change' event. We listen to it to update dropZone innerText
     */
    onInputChange(event) {
      console.log('On Input change triggered', this.inputTarget.files[0])
      this.zoneTarget.innerText = this.inputTarget.files[0]?.name;
      this.zoneTarget.classList.add('hover');
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
