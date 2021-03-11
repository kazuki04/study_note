window.addEventListener("load", () => {
  input_field = document.getElementById("avatar_input")
  const previewField = document.getElementById("preview_field")
  
  input_field.addEventListener("change", (e) => {
    const file = e.target.files[0];
    const imageContent = document.querySelector('img');

    const blobImage = document.createElement('img');
    blobImage.setAttribute("id", "avatar_img")
    blobImage.setAttribute("height", 150)
    blobImage.setAttribute("width", 150)

    if (file){
      const blobUrl = window.URL.createObjectURL(file);
      blobImage.setAttribute('src', blobUrl)
    } else {
      imageContent.remove();
      blobImage.setAttribute("src", "/app/assets/images/avatar_icon.png")
    }

      if (imageContent){
        imageContent.remove();
      }

    previewField.appendChild(blobImage);
  });

  const delete_icon_btn = document.getElementById("avatar_delete_btn")
    delete_icon_btn.addEventListener("click", () => {
    const sample_avatar_icon = document.createElement("img");
    sample_avatar_icon.setAttribute("src", "/app/assets/images/avatar_icon.png")
    previewField.appendChild(sample_avatar_icon);
  });

});