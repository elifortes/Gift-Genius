import { Controller } from "@hotwired/stimulus"
import { put } from "@rails/request.js";
import Sortable from 'sortablejs';

// Connects to data-controller="sortable"
export default class extends Controller {
  static values = {
    group: String
  }


  connect() {
    console.log('stimulus sortable controller is enabled !!!')
    this.sortable = Sortable.create(this.element, {
      onEnd: this.onEnd.bind(this),
      group: this.groupValue
    });
  }

  onEnd(event) {
    var sortableUpdateUrl = event.item.dataset.sortableUpdateUrl
    var newIndex = event.newIndex
    console.log(sortableUpdateUrl)
    console.log(newIndex)

    put(sortableUpdateUrl, {
      body: JSON.stringify({ row_order_position: newIndex }),
    })
  }
}