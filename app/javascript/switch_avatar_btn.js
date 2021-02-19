$(function(){
  $(".select").on("click", function(){
    if ($(".select_list").css("display") == "none"){
      $(".select_list").css("display", "block");
    } else {
      $(".select_list").css("display", "none");
    }
  })
})