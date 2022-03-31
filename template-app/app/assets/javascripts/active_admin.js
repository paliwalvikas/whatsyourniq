//= require active_admin/base
//= require jquery

function calculateRating(product_id){
  $.ajax({
    url: "/bx_block_catalogue/products/" + product_id, 
    method: "PATCH",  
    dataType: "json",
    data: {},
    error: function (xhr, status, error) {
      console.error('AJAX Error: ' + status + error);
      alert(error);
    },
    success: function (response) {
      window.location = "/admin/bx_block_catalogue_products/"+product_id
      alert("Successfully calculated!");
    }
  })
}