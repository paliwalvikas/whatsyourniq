//= require active_admin/base
//= require jquery3
//= require activeadmin/quill_editor/quill
//= require activeadmin/quill_editor_input
function calculateRating(product_id) {
  $.ajax({
    url: "/bx_block_catalogue/products/" + product_id,
    method: "PATCH",
    dataType: "json",
    data: {},
    error: function (xhr, status, error) {
      console.error("AJAX Error: " + status + error);
      alert(error);
    },
    success: function (response) {
      window.location = "/admin/products/" + product_id;
      alert("Successfully calculated!");
      // $(".alert-success").css("display", "block");
      // $(".alert-success").append("<P>This is a message");
    },
  });
}

function reload() {
  (window.location = "/admin/import_statuses").reload(true);
}

function generateModel(e){
  var modal = document.createElement("div");
  modal.classList.add("modal");

  var modalContent = document.createElement("div");
  modalContent.classList.add("modal-content");

  var modalBody = document.createElement("div");
  modalBody.classList.add("modal-body");
  modalBody.innerHTML = '<img class="img_preview" src='+ e.src +'>';

  modalContent.appendChild(modalBody);
  modal.appendChild(modalContent);

  document.body.appendChild(modal);
  modal.style.display = "block";

  modal.addEventListener("click", function(event) {
    if (event.target == modal) {
      modal.remove();
    }
  });
}


$(document).ready(function(){
  $('#bx_block_chat_chat_answer_type').on('change', function() {
    if ($('#bx_block_chat_chat_answer_type').val() == "radio_button" || $('#bx_block_chat_chat_answer_type').val() == "check_box") {
      $('.answer_options').show();
    } else {
      $('.answer_options').hide();
    }
  })
  $('.answer_options').hide();
})