window.addEventListener("DOMContentLoaded", () => {
  const pen_icon = document.getElementsByClassName("fa-edit")[0];

  pen_icon.addEventListener("click", () => {
    const goal_form = document.getElementById("goal_form");
    const goal_list = document.getElementsByClassName("goal_list");
    if(getComputedStyle(goal_form).display == "none"){
      goal_form.style.display = "block";
      goal_list.style.display = "none"
    } else {
      goal_form.style.display = "none";
      goal_list.style.display = "block" 
    }
  })
})