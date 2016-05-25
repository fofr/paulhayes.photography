var PostFinder = require('./post-finder');
hexo.extend.helper.register('expandPhotos', function(content){
  var hexo = this,
      postFinder = new PostFinder(hexo);

  function expandPhotos(match, slug, modifier, caption) {
    post = postFinder.photoFromSlug(slug);

    return hexo.partial('_partial/album-photo', {
      post: post,
      caption: caption,
      modifier: modifier
    });
  }

  // Complicated Regexp help:
  // http://stackoverflow.com/questions/3850074/regex-until-but-not-including
  //
  // Steps:
  // data-slug="([\w-]*)" Match slug
  // ((?:(?!<\/photo)[^])*) Non-matching lazy-lookup to ensure not match </photo>
  //                        Match any character (including line breaks, which `.` doesn't include)
  //                        Zero or more repetitions, captured
  // Pass 3 captures to `expandPhotos` function for replacing
  return content.replace(/<photo data-slug="([\w-]*)" data-modifier="([\w-]*)">((?:(?!<\/photo)[^])*)<\/photo>/gm, expandPhotos);
});
