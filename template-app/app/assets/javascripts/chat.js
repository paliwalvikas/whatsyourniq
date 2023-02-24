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