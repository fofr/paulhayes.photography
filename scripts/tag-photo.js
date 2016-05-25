/*
  Usage: {% photo photo-slug %}Caption{% endphoto %}
  Uses `helper-expand-photos` to expand into full image
*/
hexo.extend.tag.register('photo', function(args, content){
  var slug = args[0],
      modifier = args[1] || '',
      markdownCaption = hexo.render.renderSync({text: content, engine: 'markdown'});

  return '<photo data-slug="' + slug + '" data-modifier="' + modifier + '">' + markdownCaption + '</photo>';
}, {ends: true});
