import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "item" ]

  toggleTargets(e) {
    this.itemTargets.forEach((target) => {
      if (target.hidden===false){
        target.hidden = true
        e.target.classList.remove('fa-eye-slash');
        e.target.classList.add('fa-eye');
        }
        else {
          target.hidden = false
          e.target.classList.remove('fa-eye');
          e.target.classList.add('fa-eye-slash');
        }
    });
  }
}
