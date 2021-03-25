window.addEventListener("load", () => {
  const input_element = document.getElementById("avatar_input");
  const avatar_upload_btn = document.getElementById("avatar_upload_btn");
  const avatar_delete_btn = document.getElementById("avatar_delete_btn");

  avatar_upload_btn.addEventListener("click", () => {
    input_element.click();
  })

  avatar_delete_btn.addEventListener("click", ()=>{
    document.getElementById("avatar_img").remove();
    document.getElementById("img_check_is").value = "false";
  })
  
})