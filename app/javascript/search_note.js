window.addEventListener("load", () => {
  const search_input_field = document.getElementById("search_input");
  const search_result_field = document.getElementById("search_result");
  const axios = require("axios");
  
  const buildSearchResultHtml = (search_result_object) => { 
    const html = `
    <div class="search_item">
      <a class="search_result_item" href="/calendars/${search_result_object.calendar_id}/notes/${search_result_object.note_id}">
        <div class="search_item_highlight">
          ${search_result_object.highlight}
        </div>
        <div class="search_item_body">
          ${search_result_object.extracted_body}
        </div>
      </a>
    </div>
    `
    return html;
  }
  
  search_input_field.addEventListener("input", () => {
    let search_input_val = search_input_field.value;
    if(search_input_val == ""){
      search_result_field.textContent = ""
      search_result_field.style.display = "none"
      return false;}
    axios.get("/search_note", {
      params: {
        search_input_val: search_input_val
      }
    })
    .then((response) => {
      search_result_field.textContent = "";
      const search_result_array = response.data.response_array;
      if(search_result_array.length == 0){
        search_result_field.style.display = "none" 
        return false;
      }

      search_result_array.forEach(search_object => {
        search_result_field.insertAdjacentHTML("beforeend", buildSearchResultHtml(search_object))
      });
      search_result_field.style.display = "block" 
    });
  })
});
