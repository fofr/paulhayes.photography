var PostFinder = function(hexo) {
  var self = this;

  self.photoFromSlug = function(slug) {
    var slug = 'photos/' + slug;
    return hexo.site.posts.findOne({slug: slug});
  };

  self.photosFromSlugs = function(slugs) {
    var posts = [];

    for (var i = 0, l = slugs.length; i < l; i++) {
      var post = self.photoFromSlug(slugs[i]);
      if (post) {
        posts.push(post);
      }
    }

    return posts;
  };
}

module.exports = PostFinder;
