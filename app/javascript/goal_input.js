$(function(){
  build_input = function(i){
    html = `
      <div class="input_item">
        <input name="goal[goal_names][]" id="goal_${i}" class="goal_input" type="text"> 
        <a id="add_btn_${i}" class="goal_add_btn" data-index="${i}" href="#">追加</a>
        <a id="delete_btn_${i}" class="goal_delete_btn" data-index="${i}" href="#">削除</a>
      </div>`
    
    return html;
  }


  $(".input_field").on("click", ".goal_add_btn", function() {
    if($(".input_field").children().length == 10){
      return false;
    } 

    index = $(this).data("index")
    if($(`#goal_${index}`).val() != ""){
      $(".input_field").append(build_input(index + 1))
    }
  })

  $(".input_field").on("click", ".goal_delete_btn", function(){
    $(this).parent().remove();
    if($(".input_field").children().length == 0){
      $(".input_field").append(build_input(0)) 
    }
  })
});