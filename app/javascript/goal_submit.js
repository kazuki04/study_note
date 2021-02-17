$(function(){

  build_html = function(li_item){
    html = `<ul class="goal_list">
              ${li_item}
            </ul>`
    return html;
  }

  $("#goal_submit_btn").on("click", function(e){
    e.preventDefault();
    const path = location.pathname
    const calendar_id = path.replace("/calendars/", '');

    const params = $("#goal_form").serializeArray()
    const goal_params = params.slice(1)
    console.log(params)
    console.log(goal_params)

    $.ajax({
      url: `/calendar/${calendar_id}/goals`,
      type: 'GET',
      data: {goal_params: goal_params},
      dataType: 'json'
    }).done(function(goal_name_array){
      let li_item = ""
      goal_name_array.forEach(goal_name => {
        li_item += `<li class="goal_list_item">${goal_name}</li>`
      });
      ul = build_html(li_item)
      $("#goal_form").css("display", "none");
      $(".goal_list").replaceWith(ul);
    })
  })
})