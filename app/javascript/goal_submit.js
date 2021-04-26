window.addEventListener("DOMContentLoaded", () => {
  const axios = require("axios");
  const path = location.pathname;
  const calendar_id = path.replace("/calendars/", '');
  const goal_form = document.getElementById("goal_form");

  goal_form.addEventListener("submit", (e) => {
    e.preventDefault();
    const formData = new FormData(goal_form);
    let form_values = formData.getAll("goal[goal_names][]")
    axios.get(`/calendar/${calendar_id}/goals`, {
      params: {
        form_values: form_values
      }
    })
    .then((response) => {
      let fetched_goal_array = response.data;
      let li_item = ""

      fetched_goal_array.forEach(goal_name => {
        li_item += `<li class="goal_list_item">${goal_name}</li>`
      }); 
      goal_form.style.display = "none";
      const goal_list = document.getElementById("goal_list");
      goal_list.innerHTML = ""
      goal_list.innerHTML = li_item
      goal_list.style.display = "block"

      document.getElementById("goal_submit_btn").removeAttribute("disabled")
    })
  })
})