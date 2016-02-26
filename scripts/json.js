hexo.extend.generator.register(hexo_generator_json_content);

function hexo_generator_json_content(site) {
  var json = {},
      content;

  content = site.posts.sort('-date').filter(function (post) {
    return post.published;
  }).map(function (post) {
    return {
      title: post.title,
      date: post.date,
      updated: post.updated,
      path: post.path,
      permalink: post.permalink,
      content: post.content
    };
  });

  json.posts = content;

  return {
    path: 'content.json',
    data: JSON.stringify(json)
  };
}
