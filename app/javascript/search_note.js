window.addEventListener("load", () => {
  const search_input_field = document.getElementById("search_input");
  const search_result_field = document.getElementById("search_result");
  const axios = require("axios");
  
  const buildSearchResultHtml = (search_result_object) => {
    // const search_result_div_element = document.createElement("div");
    const search_result_link = document.createElement("a");
    search_result_link.setAttribute("class", "search_result_item");
    search_result_link.setAttribute("href", `/calendars/${search_result_object.calendar_id}/notes/${search_result_object.note_id}`)

    const search_result_highlight_div_element = document.createElement("div");
    search_result_highlight_div_element.setAttribute("class", "search_item_highlight");
    search_result_highlight_div_element.style.height = '30px';
    search_result_highlight_div_element.style.paddingLeft = '10px';  
    search_result_highlight_div_element.style.backgroundColor = '#0089fdba';
    search_result_highlight_div_element.style.lineHeight = '30px';
    search_result_highlight_div_element.style.color = "#ffff"
    
    const search_result_body_div_element = document.createElement("div");
    search_result_body_div_element.setAttribute("class", "search_item_body");
    search_result_body_div_element.style.height = '50px';
    search_result_body_div_element.style.padding = '10px';
    search_result_body_div_element.style.color = "black"

    search_result_highlight_div_element.textContent = search_result_object.highlight;
    search_result_body_div_element.textContent =  search_result_object.extracted_body;

    search_result_link.appendChild(search_result_highlight_div_element);
    search_result_link.appendChild(search_result_body_div_element);

    return search_result_link;
  };
  
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
        search_result_field.appendChild(buildSearchResultHtml(search_object))
      });
      search_result_field.style.display = "block" 
    });
  })
});