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

function call_forms(url, condition){
  var spinner = new Spinner(opts);
  var url = url; 
  values = "";
  if (url == "/promotions/new" || url == "/coefficients/new") {
    values = {
      start_date: $("#condition_start_date").val() ,
      end_date: $("#condition_end_date").val()
    }
  }
  $.ajax({
    type: 'GET',
    url: url,
    data: values,
    beforeSend: function() {
      spinner.spin(document.getElementById('modal-spin'));
    },
    success: function(data) {
      $('#myModal div.modal-dialog div.modal-content div.modal-body').append(data);
      if (url == "/promotions/new") {
        $('form#new_promotion').append('<input type="hidden" name="promotion[condition_id]" value="'+condition+'">');
        $('#myModal div.modal-dialog').addClass('modal-promotion');
      }else{
        $('form#new_coefficient').append('<input type="hidden" name="coefficient[condition_id]" value="'+condition+'">');
        $('#myModal div.modal-dialog').addClass('modal-coefficient');
      }
      $('#myModal').modal('show');
      $('#myModal').on('hidden.bs.modal', function (e) {
        $("#myModal div.modal-dialog div.modal-content div.modal-body").empty();
        if (url = "/promotions/new") {
          $('#myModal div.modal-dialog').removeClass('modal-promotion');
        }else{
          $('#myModal div.modal-dialog').removeClass('modal-coefficient');
        }
      });
    },
    complete: function() {
      spinner.stop();
    }
  });
}

function change_state(what_do, resource, action) {
  if (what_do == "promotions") {
    var url = "/promotions/"+resource+action
  }else{
    var url = "/coefficients/"+resource+action
  }

  $.ajax({
    url: url,  
    type: "PATCH",
    beforeSend: function(){
    // spinner.spin(document.getElementById('modal-spin'));
    },
    success: function(result){
      $('#'+resource).replaceWith(result);
    },
    complete: function(){
    // spinner.stop(document.getElementById('modal-spin'));
    }
  });
}

$(document).ready(function() { 
  opts = spin_opts();
  $('body').on('click','.button-new-promotion', function(){
    call_forms("/promotions/new", $(this).attr('data-condition'));
  });

  $('body').on('click','.button-new-coefficient', function(){
    call_forms("/coefficients/new", $(this).attr('data-condition'));
  });

  $('body').on('click','.button-edit-promotion', function(){
    call_forms("/promotions/"+$(this).attr('data-promotion')+"/edit", $(this).attr('data-condition'));
  });

  $('body').on('click','.button-edit-coefficient', function(){
    call_forms("/coefficients/"+$(this).attr('data-coefficient')+"/edit", $(this).attr('data-condition'));
  });

  $('body').on('click', '.button-enable-promotion,.button-disable-promotion', function (e) {
      e.preventDefault(); // stops default behavior
      if ( confirm($(this).attr('data-message')) ) {
          change_state("promotions", $(this).attr('data-promotion'), $(this).attr('data-action'))
      }
  });

  $('body').on('click', '.button-enable-coefficient,.button-disable-coefficient', function (e) {
      e.preventDefault(); // stops default behavior
      if ( confirm($(this).attr('data-message')) ) {
          change_state("coefficients",$(this).attr('data-coefficient'), $(this).attr('data-action'))
      }
  });

  $('body').on('click', '.button-delete-promotion', function (e) {
      e.preventDefault(); // stops default behavior
      var button = $(this);
      var id = button.attr('data-promotion');
      if ( confirm("Esta seguro de eliminar esta promocion?") ) {
          $.ajax({
              url: "/promotions/"+id,  
              type: "DELETE",
              beforeSend: function(){
              // spinner.spin(document.getElementById('modal-spin'));
              },
              success: function(result){
                  $('tr#'+id).remove();
              },
              complete: function(){
              // spinner.stop(document.getElementById('modal-spin'));
              }
          });  
      }
  });

  $('body').on('click', '.button-delete-coefficient', function (e) {
      e.preventDefault(); // stops default behavior
      var button = $(this);
      var id = button.attr('data-coefficient');
      if ( confirm("Esta seguro de eliminar esta coeficiente?") ) {
          $.ajax({
              url: "/coefficients/"+id,  
              type: "DELETE",
              beforeSend: function(){
              // spinner.spin(document.getElementById('modal-spin'));
              },
              success: function(result){
                  $('tr#'+id).remove();
              },
              complete: function(){
              // spinner.stop(document.getElementById('modal-spin'));
              }
          });  
      }
  });

  $('body').on('click', '.button-clone-promotion', function (e) {
      e.preventDefault(); // stops default behavior
      if ( confirm("Esta seguro de clonar esta promocion?") ) {
        $.ajax({
            url: "/promotions/"+$(this).attr('data-promotion')+"/clone",  
            type: "POST",
            beforeSend: function(){
            // spinner.spin(document.getElementById('modal-spin'));
            },
            success: function(result){
              $('#promotions_table tbody').append(result);
            },
            complete: function(){
            // spinner.stop(document.getElementById('modal-spin'));
            }
          });  
      }
  });
  $('body').on('click', '.button-clone-coefficient', function (e) {
      e.preventDefault(); // stops default behavior
      if ( confirm("Esta seguro de clonar esta coeficiente?") ) {
        $.ajax({
          url: "/coefficients/"+$(this).attr('data-coefficient')+"/clone",  
          type: "POST",
          beforeSend: function(){
          // spinner.spin(document.getElementById('modal-spin'));
          },
          success: function(result){
            $('#coefficients_table tbody').append(result);
          },
          complete: function(){
          // spinner.stop(document.getElementById('modal-spin'));
          }
        });  
      }
  });   
});





