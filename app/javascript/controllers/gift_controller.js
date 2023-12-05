import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gift"
export default class extends Controller {
  connect() {
  }
}

document.addEventListener("DOMContentLoaded", function() {
  // Check if there's a flash message
  const flashMessage = document.querySelector('.flash-message');
  if (flashMessage) {
    Swal.fire({
      icon: 'success',
      title: 'Notification',
      text: flashMessage.innerText,

    });
  }
});
