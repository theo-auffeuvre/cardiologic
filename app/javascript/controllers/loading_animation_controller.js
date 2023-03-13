import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading-animation"
export default class extends Controller {
  static targets = ['divglobale', 'divgif']
  connect() {
    console.log("chang");
    console.log('controller loading animation connecté');
  }


  animation(event){
    event.preventDefault();
    const target = event.currentTarget
    this.divglobaleTarget.classList.add('d-none');
    this.divgifTarget.classList.remove('d-none');

    console.log(target);
    setTimeout(() => {
      console.log(target);
      target.submit()
    }, 3000);
  }
}
