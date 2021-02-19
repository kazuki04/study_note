$(function(){
  const input = $("#avatar_input")[0]
  $("#avatar_upload_btn").on("click", function(){
    input.click();
  })

  $("#avatar_delete_btn").on("click", function(){
    $("#avatar_img").remove();
    $("#img_check_is").val(false)
  })
})