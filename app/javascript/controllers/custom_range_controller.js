import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['minPrice', 'maxPrice', 'range'];

  connect() {
    this.minPriceTarget.textContent = this.rangeTarget.min;
    this.maxPriceTarget.textContent = '$' + this.rangeTarget.value;
    this.updatePriceField();
  }

  rangeUpdate() {
    this.maxPriceTarget.textContent = '$' + this.rangeTarget.value;
    this.updatePriceField();
  }

  updatePriceField() {
    // Update the hidden field value with the range slider value
    document.getElementById("gift_price").value = this.rangeTarget.value;
  }
}
