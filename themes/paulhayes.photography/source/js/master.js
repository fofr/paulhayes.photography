(function(){
  $('a[data-key]').each(bindKeyToLink);
})();

function bindKeyToLink() {
  var element = $(this);
  Mousetrap.bind(element.data('key'), function() {
    element.focus();
    window.location.href = element.attr('href');
  });
}

var _gaq=[['_setAccount','UA-59763-15'],['_trackPageview']];(function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];g.async=1;g.src='//www.google-analytics.com/ga.js';s.parentNode.insertBefore(g,s)}(document,'script'));
