window.addEventListener("DOMContentLoaded", () => {
  const search_icon = document.getElementById("search_icon");
  const search_result_field = document.getElementById("search_result");
  search_icon.addEventListener("click", () => {
    const search_form = document.getElementById("search_form");
    if(getComputedStyle(search_form).display == "none"){
      search_form.style.display = "block";
    } else {
      search_form.style.display = "none";
      search_result_field.style.display = "none"
    }
  })
})