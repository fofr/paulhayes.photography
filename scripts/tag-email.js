/* Usage: {% contact %} */
hexo.extend.tag.register('contact', function(args, content, options){
  return '<br /><b>' + hexo.config.site_email + '</b>';
});
