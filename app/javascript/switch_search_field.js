$(function(){
  $(".fa-search").on("click", function(){
    if($("#search_form").css("display") == "none"){
      $("#search_form").css("display", "block");
    } else {
      $("#search_form").css("display", "none");
      $("#search_result").css("display", "none");
    }
  })
})