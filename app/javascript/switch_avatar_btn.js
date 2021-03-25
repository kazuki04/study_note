window.addEventListener("load", () => {
  const image_select_btn = document.getElementById("select");
  const select_list = document.getElementById("select_list");

  image_select_btn.addEventListener("click", () => {
    if(getComputedStyle(select_list).display == "none"){
      select_list.style.display = "block";
    } else {
      select_list.style.display = "none";
    }
  })
})