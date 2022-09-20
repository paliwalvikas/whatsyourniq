//= require active_admin/base
//= require jquery3
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
  (window.location = "/admin/product_import_statuses").reload(true);
}
