hexo.extend.generator.register(hexo_generator_json_content);

function hexo_generator_json_content(site) {
  var posts = {
      raw: false,
      content: false,
      title: true,
      slug: true,
      date: true,
      updated: true,
      comments: true,
      path: true,
      link: true,
      permalink: true,
      excerpt: true,
      text: true,
      categories: true,
      tags: true
    },

    json = {},
    content;

  content = site.posts.sort('-date').filter(function (post) {
    return post.published;
  }).map(function (post) {
    return {
      title: posts.title ? post.title : null,
      slug: posts.slug ? post.slug : null,
      date: posts.date ? post.date : null,
      updated: posts.updated ? post.updated : null,
      comments: posts.comments ? post.comments : null,
      path: posts.path ? post.path : null,
      link: posts.link ? post.link : null,
      permalink: posts.permalink ? post.permalink : null,
      raw: posts.raw ? post.raw : null,
      content: posts.content ? post.content : null,
      categories: posts.categories ? post.categories.map(function (cat) {
        return {
          name: cat.name,
          slug: cat.slug,
          permalink: cat.permalink
        };
      }) : null,
      tags: posts.tags ? post.tags.map(function (tag) {
        return {
          name: tag.name,
          slug: tag.slug,
          permalink: tag.permalink
        };
      }) : null
    };
  });

  json.posts = content;

  return {
    path: 'content.json',
    data: JSON.stringify(json)
  };
}
