window.addEventListener("load", () => {
  const search_input_field = document.getElementById("search_input");
  
  const axios = require("axios");

  search_input_field.addEventListener("input", () => {
    let search_input_val = search_input_field.value;
    axios.get("/search_note", {
      params: {
        search_input_val: search_input_val
      }
    })
    .then((response) => {

    });
  })
});