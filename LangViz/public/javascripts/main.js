$(document).ready(function() {
  $('#form').submit(function(e) {
    e.preventDefault();
    let data = {};
    $.each($('#form').serializeArray(), function(i, field) {
      data[field.name] = field.value;
    });

    translate(data['key'], data['translation'], (err,result) => {
      if(err) {
        new Noty({
          theme: 'bootstrap-v3',
          type: 'error',
          text: 'Error submitting',
          timeout: false
        }).show();
        return console.log(err);
      }
      console.log(result);
      new Noty({
        theme: 'bootstrap-v3',
        type: 'info',
        text: 'Submitted!',
        timeout: false
      }).show();

    });
  });
});