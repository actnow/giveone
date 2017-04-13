$(function() {
  switch (window.location.pathname) {
    case '/donate':
      $('#donate').addClass('active');
      break;
    case '/volunteer':
      $('#activation').addClass('active');
      break;
    case '/account':
    case '/users/sign_in':
      $('#account').addClass('active');
      break;
  }

  var animatables = $('#account p, #activation p, #donate p').map(function(i, text) {
    return { jEl: $(text), orig: $(text).width() };
  });

  $('#collapse-desktop-nav').waypoint({
    handler: function(direction) {
      var $nav = $('#desktop_nav');
      if (direction === "down") {
        animatables.each(function(index, i) {
          i.jEl.animate({ width: 0, opacity: 0 }, { duration: 300 });
        });
        return $nav.addClass('collapsed');
      }
      animatables.each(function(index, i) {
        i.jEl.animate({ width: i.orig, opacity: 1 }, { duration: 300 });
      });
      $nav.removeClass('collapsed');
    }
  });
});
