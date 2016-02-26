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

  site.tags.each(function(tag) {
    tagPosts = tag.posts.sort('-date').map(function(post) {
      return postObject(post);
    });

    routes.push({
      path: tag.path.replace(/\/$/, "") + '.json',
      data: JSON.stringify(indexObject(tagPosts))
    });
  });

  routes.push({
    path: 'index.json',
    data: JSON.stringify(indexObject(all))
  });

  return routes;

  function indexObject(posts) {
    return {
      posts: posts
    }
  }

  function postObject(post) {
    return {
      title: post.title,
      date: post.date,
      updated: post.updated,
      path: '/' + post.path,
      api_path: '/' + post.path.replace(/\/$/, "") + '.json',
      permalink: post.permalink,
      content: post.content,
      photo: hexo.config.image_dir + '1720/' + post.slug + '.jpg',
      thumbnail: hexo.config.image_dir + 'square/380/' + post.slug + '.jpg',
      tags: post.tags.map(function (tag) {
        return {
          name: tag.name,
          path: '/' + tag.path,
          api_path: '/' + tag.path.replace(/\/$/, "") + '.json',
          permalink: tag.permalink
        };
      })
    }
  }
}
