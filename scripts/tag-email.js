/* Usage: {% contact %} */
hexo.extend.tag.register('contact', function(args, content, options){
  return '<br /><b><a href="mailto:' + hexo.config.site_email + '">' + hexo.config.site_email + '</a></b>';
});
