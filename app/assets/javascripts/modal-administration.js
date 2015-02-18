function spin_opts() {
  return {
    lines: 8, // The number of lines to draw
    length: 10, // The length of each line
    width: 5, // The line thickness
    radius: 15, // The radius of the inner circle
    corners: 1, // Corner roundness (0..1)
    rotate: 0, // The rotation offset
    direction: 1, // 1: clockwise, -1: counterclockwise
    color: '#4a4943', // #rgb or #rrggbb or array of colors
    speed: 1, // Rounds per second
    trail: 60, // Afterglow percentage
    shadow: false, // Whether to render a shadow
    hwaccel: false, // Whether to use hardware acceleration
    className: 'spinner', // The CSS class to assign to the spinner
    zIndex: 2e9, // The z-index (defaults to 2000000000)
    top: 'auto', // Top position relative to parent in px
    left:'auto' // Left position relative to parent in px
  };
}

function call_forms(url){
  var spinner = new Spinner(opts);
  $.ajax({
    type: 'GET',
    url: url,
    beforeSend: function() {
      spinner.spin(document.getElementById('modal-spin'));
    },
    success: function(data) {
      $('#myModal div.modal-dialog div.modal-content div.modal-body').append(data);
      $('#myModal').modal('show');
      $('#myModal').on('hidden.bs.modal', function (e) {
        $("#myModal div.modal-dialog div.modal-content div.modal-body").empty();
      });
    },
    complete: function() {
      spinner.stop();
    }
  });
}

function change_state_of_promotion(promotion, action) {
  // id = JSON.parse(promotion).$oid;
  $.ajax({
    url: "/promotions/"+promotion+action,  
    type: "PATCH",
    beforeSend: function(){
    // spinner.spin(document.getElementById('modal-spin'));
    },
    success: function(result){
      $('#'+promotion).replaceWith(result);
    },
    complete: function(){
    // spinner.stop(document.getElementById('modal-spin'));
    }
  });
}

$(document).ready(function() { 
  opts = spin_opts();
  $('body').on('click','.button-new-promotion', function(){
    call_forms("/promotions/new");
  });

  $('body').on('click','.button-edit-promotion', function(){
    call_forms("/promotions/"+$(this).attr('data-promotion')+"/edit");
  });

  $('body').on('click', '.button-enable-promotion,.button-disable-promotion', function (e) {
      e.preventDefault(); // stops default behavior
      if ( confirm($(this).attr('data-message')) ) {
          change_state_of_promotion($(this).attr('data-promotion'), $(this).attr('data-action'))
      }
  });
  $('body').on('click', '.button-delete-promotion', function (e) {
      e.preventDefault(); // stops default behavior
      if ( confirm("Esta seguro de eliminar esta promocion?") ) {
          $.ajax({
              url: "/promotions/"+$(this).attr('data-promotion'),  
              type: "DELETE",
              beforeSend: function(){
              // spinner.spin(document.getElementById('modal-spin'));
              },
              success: function(result){
                  $('#'+$('.button-delete-promotion').attr('data-promotion')).remove();
              },
              complete: function(){
              // spinner.stop(document.getElementById('modal-spin'));
              }
          });  
      }
  });  
});





