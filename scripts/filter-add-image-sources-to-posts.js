hexo.extend.filter.register('before_post_render', function(data) {
  if (data.layout == "photo") {
    var dir = hexo.config.image_dir,
        filename = data.slug.replace(/^photos\//,'') + '.jpg';

    data.filename = filename;
    data.image = dir + '1720/' + filename;
    data.squareThumbnail = dir + 'square/380/' + filename;
    data.openGraphImage = dir + 'watermarked/1720/' + filename;
    data.twitterImage = dir + 'watermarked/435/' + filename;
  }
  return data;
});
