$(function(){
  $(".fa-edit").on("click", function(){
    if ($("#goal_form").css("display") == "none"){
      $("#goal_form").css("display", "block");
      $(".goal_list").css("display", "none");
    } else {
      $("#goal_form").css("display", "none");
      $(".goal_list").css("display", "block");
    }
  })
})