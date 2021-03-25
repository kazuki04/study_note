window.addEventListener("DOMContentLoaded", () => {
  const search_icon = document.getElementById("search_icon");
  search_icon.addEventListener("click", () => {
    const search_form = document.getElementById("search_form");
    if(getComputedStyle(search_form).display == "none"){
      search_form.style.display = "block";
    } else {
      search_form.style.display = "none";
    }
  })
})