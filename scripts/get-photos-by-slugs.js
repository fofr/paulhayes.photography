hexo.extend.helper.register('getPhotosBySlug', function(slugsArray){
  var posts = [],
      hexo = this;

  for (var i = 0, l = slugsArray.length; i < l; i++) {
    var slug = slugsArray[i],
        post = hexo.site.posts.findOne({slug: slug});

    if (post) {
      posts.push(post);
    }
  }

  return posts;
});
