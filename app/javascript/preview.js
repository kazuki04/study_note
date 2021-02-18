window.addEventListener("load", () => {
  input_field = document.getElementById("avatar_input")
  input_field.addEventListener("change", (e) => {
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);
    const previewField = document.getElementById("preview_field")

    const blobImage = document.createElement('img');
    blobImage.setAttribute("height", 100)
    blobImage.setAttribute("width", 100)
    blobImage.setAttribute('src', blobUrl)

    const imageContent = document.querySelector('img');
      if (imageContent){
        imageContent.remove();
      }

    previewField.appendChild(blobImage);
  });
});