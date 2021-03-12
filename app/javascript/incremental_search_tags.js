window.addEventListener("DOMContentLoaded", () => {
  const tag_field = document.getElementById("note_tag_names");
  const search_tag_list = document.getElementById("search_tag_list")
  const axios = require('axios');
  tag_field.addEventListener("input", () => {
    let input_val = tag_field.value;
    
    // 入力後、削除で入力欄がからの場合、通信しない
    if (input_val == "") {
      search_tag_list.innerHTML = ""
      return false;
    };

    // カンマ以降の文字を取得
    if (input_val.match(",") != null){
      let last_comma = 0;
      for(var i = 0; i < input_val.length; i++){
        if (input_val[i] == ","){
          last_comma = i
        }
      }

      input_val = input_val.slice(last_comma + 1) 
      if (input_val == "") {
        return false;
      }

    }

    let all_input_val = tag_field.value;
    axios.get('/incremental_search_tags', {
      params: {
        input_val: input_val,
        all_input_val: all_input_val
      }
    })
    .then((response) => {
      const response_tag_length = response.data.tags.length;
      if(response_tag_length == 0) {
        return false;
      };
      tag_list = response.data.tags;
      search_tag_list.innerHTML = ""

      all_input_val = document.getElementById("note_tag_names").value;

      tag_list.forEach(tag_object => {
        console.log(all_input_val.match(tag_object.tag_name))


        const tagElement = document.createElement("div");
        tagElement.style.padding = "6px"
        tagElement.style.backgroundColor = "#e6e6e6"
        tagElement.style.border = "thin solid #ffff"
        tagElement.dataset.tag_id = tag_object.id
        tagElement.innerHTML = tag_object.tag_name

        search_tag_list.appendChild(tagElement)
        
        tagElement.addEventListener("click", function(){
          const clicked_tag = this;
          let clicked_tag_name = clicked_tag.textContent;
          const tag_input_field = document.getElementById("note_tag_names")

            entered_string = tag_input_field.value
          if(entered_string.match(",") == null) {
            debugger
              tag_input_field.value = ""
              tag_input_field.value = clicked_tag_name + ","
          } else {
            
            last_comma = 0

            // 最後のカンマを取得
            for(var i = 0; i < entered_string.length; i++){
              if(entered_string[i] == ","){
                last_comma = i
              }
            }

            let string =  entered_string.slice(last_comma)
            let sliced_string = entered_string.replace(string, "")
            const entered_string_plus_tag = sliced_string + `,${clicked_tag_name},`;
            
            tag_input_field.value = ""
            tag_input_field.value = entered_string_plus_tag 
          }



          
          this.remove();

        })
      });
    })
    .catch(() => {

    })


  });
});