import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="darkmode"
export default class extends Controller {
  connect() {
  }
}







/* //////////////////////////////////////////////
  Plus d'informations liées à la solution  :
  //////////////////////////////////////////////

*/

/*
Toutes le fonctions ci-dessous peuvent être optimisées
elles sont même volontairement non optimisées
Elles sont là juste pour vous présenter le concept à vous de les améliorer
*/
/*  code js a convertir stimulus
function setMode(oEvent){
  document.body.classList.replace(aModes[Number(!this.checked)],aModes[Number(this.checked)]);
  localStorage.setItem('mode',aModes[Number(this.checked)]);
  this.parentNode.nextElementSibling.innerHTML = (this.checked)? "Dark mode":"White mode"
}

function loadMode(){
  let sMode = localStorage.getItem('mode');
  document.forms["mytheme"]["theme-mode"].checked = sMode == aModes[1];
  setMode.call(document.forms["mytheme"]["theme-mode"])
}
let aModes = ["mode-white", "mode-dark"];
document.addEventListener('DOMContentLoaded',function(){
  document.body.classList.add(aModes[0]);
  document.forms["mytheme"]["theme-mode"].addEventListener('click', setMode);
  loadMode()
});

*/
