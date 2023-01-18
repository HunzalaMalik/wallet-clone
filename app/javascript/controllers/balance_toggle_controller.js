import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "item" ]

  toggleTargets(e) {
    this.itemTargets.forEach((target) => {
      target.hidden = target.hidden ? false : true;
      e.target.classList.replace(target.hidden ? 'fa-eye' : 'fa-eye-slash', target.hidden ? 'fa-eye-slash' : 'fa-eye');
    });
  }
}
