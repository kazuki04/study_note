window.addEventListener("DOMContentLoaded", () => {
  const note_submit_btn = document.getElementById("note_submit_btn");
  note_submit_btn.addEventListener("click", (e) => {
    e.preventDefault();
    const note_form = document.getElementById("note_form");
    const input_body_val = document.getElementById("note_body").textContent;

    const hidden_input = `<input value=${input_body_val} type="hidden" name='note[note_body]'>`;
    note_form.insertAdjacentHTML("beforeend", hidden_input);
    note_form.submit();
  })
})