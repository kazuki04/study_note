$(function(){
  build_input = function(i){
    html = `
      <div class="input_item">
        <input name="goal[goal_names][]" id="goal_${i}" class="goal_input" type="text" data-index="${i}"> 
        <a id="delete_btn_${i}" class="goal_delete_btn" data-index="${i}" href="#">削除</a>
      </div>`
    
    return html;
  }


  $("#add_btn").on("click",  function(e) {
    e.preventDefault()
    if($("#input_field").children().length == 10){
      return false;
    }
    
    last_input = $(".goal_input:last")
    last_index = last_input.data("index")
    if($(`#goal_${last_index}`).val() != ""){
      $("#input_field").append(build_input(last_index + 1))
    }
  })

  $("#input_field").on("click", ".goal_delete_btn", function(){
    $(this).parent().remove();
    if($(".input_field").children().length == 0){
      $(".input_field").append(build_input(0)) 
    }
  })
});