var PostFinder = require('./post-finder');

hexo.extend.helper.register('getPhotosBySlug', function(slugs){
  var hexo = this,
      postFinder = new PostFinder(hexo);

  return postFinder.photosFromSlugs(slugs);
});
