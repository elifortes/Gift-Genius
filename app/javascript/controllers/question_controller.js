// import { Controller } from "stimulus";
// import axios from 'axios';

// export default class extends Controller {
//   static targets = ["output"];

//   updateQuestions(event) {
//     const subcategory = event.target.value;
//     axios.get(`/fetch_external_data?category=${subcategory}`)
//       .then(response => this.outputTarget.innerHTML = this.formatResponse(response.data))
//       .catch(error => console.error("Error:", error));
//   }

//   formatResponse(data) {
//     // Assuming data is an array of book objects as formatted in the fetch_books_from_google method
//     return data.map(book => `
//       <div>
//         <h3>${book.title}</h3>
//         <p>Authors: ${book.authors}</p>
//         <p>Rating: ${book.average_rating}</p>
//         <img src="${book.thumbnail}" alt="Book cover">
//       </div>
//     `).join('');
//   }
// }
