hexo.extend.generator.register(hexo_generator_json_content);

function hexo_generator_json_content(site) {
  var routes = [],
      all;

  all = site.posts.sort('-date').map(function(post) {
    return postObject(post);
  });

  routes = site.posts.sort('-date').map(function(post) {
    return {
      path: post.path.replace(/\/$/, "") + '.json',
      data: JSON.stringify(postObject(post))
    };
  });

  routes.push({
    path: 'api/all.json',
    data: JSON.stringify({posts: all})
  });

  return routes;

  function postObject(post) {
    return {
      title: post.title,
      date: post.date,
      updated: post.updated,
      path: '/' + post.path,
      permalink: post.permalink,
      content: post.content,
      file: hexo.config.image_dir + '1720/' + post.slug + '.jpg'
    }
  }
}
