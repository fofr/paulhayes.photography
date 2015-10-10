/*
  Hero tag

  Creates a <figure> containing
  * an image with alt text
  * a link to a full size version of image
  * a <figcaption> based on content of tag
  * capability to render that content as markdown

  Uses jsdom and jquery to strip out HTML from
  rendered markdown version of caption for use as
  alt text.

  Usage:
  {% hero image %}
  Some _caption_ with markdown
  {% endfigure}
*/

var jsdom = require('jsdom').jsdom,
    window = jsdom("").parentWindow,
    $ = require('jquery')(window);

hexo.extend.tag.register('hero', function(args, content) {

  var image_dir = hexo.config.image_dir,
      render = hexo.render,
      image = hexo.config.image_dir + '1720/' + args[0] + '.jpg',
      url = args[1],
      markdownCaption = render.renderSync({text: content, engine: 'markdown'}),
      renderedCaption = $(markdownCaption).unwrap().html(), //remove wrapping paragraph element
      caption = $(markdownCaption).text();

  return '<figure class="hero-image"><div class="photo-image-wrapper"><a href="' + url +'"><img src="' + image +'" alt="'+ caption +'" class="photo-image"></a></div><figcaption class="hero-image-caption">'+ renderedCaption +'</figcaption></figure>';
}, {ends: true});
