// visual tabs manage function
(function visualTabs() {
  $('#visual-tabs a').click(function (e) {
    $(this).tab('show');
  });

  // add selected tab href in the current url hash value
  $('ul.nav-tabs > li > a').on('shown.bs.tab', function (e) {
    var id = $(e.target).attr('href').substr(1);
    window.location.hash = id;
    $('body').scrollTop(0);
  });

  // add default url hash, if it's not set
  var hash = window.location.hash;
  if(!hash) {
    window.location.hash = 'highfreq';
  }

  // switch to the currently selected tab using current url hash
  $('#visual-tabs a[href="' + hash + '"]').tab('show');
})();
