import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="balance-toggle"
export default class extends Controller {
  static targets = [ "item" ]

  toggleTargets(e) {
    this.itemTargets.forEach((el) => {
      console.log(el)
      if (el.hidden===false){
      el.hidden = true
      e.target.classList.remove('fa-eye-slash');
      e.target.classList.add('fa-eye');
      }
      else {
        el.hidden = false
        e.target.classList.remove('fa-eye');
        e.target.classList.add('fa-eye-slash');
      }
    });

  }
}
