hexo.extend.filter.register('before_post_render', function(data) {
  if (data.layout == "photo" || typeof data.cover === "string") {
    var dir = hexo.config.image_dir,
        slug = data.cover || data.slug,
        filename =  slug.replace(/^photos\//,'') + '.jpg';

    data.filename = filename;
    data.image = dir + '1720/' + filename;
    data.albumImage = dir + '860/' + filename;

    if (data.layout == "blog") {
      data.openGraphImage = dir + 'blog/860/' + filename;
      data.twitterImage = dir + 'blog/435/' + filename;
    } else {
      data.squareThumbnail = dir + 'square/380/' + filename;
      data.openGraphImage = dir + 'watermarked/1720/' + filename;
      data.twitterImage = dir + 'watermarked/435/' + filename;
    }
  }

  return data;
});
