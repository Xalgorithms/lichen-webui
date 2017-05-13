$(document).on('turbolinks:load', function () {
  var $body = $('body');

  App.init_on_page($body.data('page'), $body.data('action'));
});
