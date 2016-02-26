hexo.extend.generator.register(json);

function json(site) {
  var routes = [],
      all;

  all = site.posts.sort('-date').map(function(post) {
    return postObject(post);
  });

  routes = site.posts.sort('-date').map(function(post) {
    return {
      path: appendJsonExtension(post.path),
      data: JSON.stringify(postObject(post))
    };
  });

  site.tags.each(function(tag) {
    tagPosts = tag.posts.sort('-date').map(function(post) {
      return postObject(post);
    });

    routes.push({
      path: appendJsonExtension(tag.path),
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
      api_path: apiPath(post.path),
      permalink: post.permalink,
      content: post.content,
      photo: hexo.config.image_dir + '1720/' + post.slug + '.jpg',
      thumbnail: hexo.config.image_dir + 'square/380/' + post.slug + '.jpg',
      tags: post.tags.map(function (tag) {
        return {
          name: tag.name,
          path: '/' + tag.path,
          api_path: apiPath(tag.path),
          permalink: tag.permalink
        };
      })
    }
  }

  function apiPath(path) {
    return '/' + appendJsonExtension(path);
  }

  function appendJsonExtension(path) {
    return path.replace(/\/$/, "") + '.json';
  }
}
