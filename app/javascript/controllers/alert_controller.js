import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    uid: Number
  }

  showNotification(event) {
    const uid = this.uidValue;
    Swal.fire({
      title: 'New group alert!',
      text: 'You have been added to a new group.',
      icon: 'info',
      confirmButtonText: 'OK'
    })
      if (uid) {
        fetch(`/update_notification/?uid=${uid}`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
          },
          body: JSON.stringify({ notification: false })
        })
        .then(response => response.json())
        .then(data => {
          console.log('Notification status updated:', data);
        });
      }

  }
}
