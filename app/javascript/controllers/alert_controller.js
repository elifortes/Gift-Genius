import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

export default class extends Controller {
  connect() {
    console.log("connected");
  }

  sweetAlertBtn(event) {
    event.preventDefault(); // Prevent form submission

    Swal.fire({
      icon: 'warning',
      title: 'Are you sure?',
      text: 'Do you want to submit this form?',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, submit it!'
    }).then((result) => {
      if (result.isConfirmed) {
        // Submit the form programmatically
        this.element.submit();
      }
    });
  }
}
