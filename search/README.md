---
description: >
  Here you should be able to find everything you need to know to accomplish the most common tasks when blogging with Hydejack.
hide_description: true
menu: true
order: 7
permalink: /search/
---

# Search
<div id="search-searchbar"></div>
{% assign posts = site.categories[page.slug] | default:site.tags[page.slug] | default:site.posts %}
<div class="post-list" id="search-hits">
</div>
{% include algolia.html %}

<p class="rss-subscribe">subscribe <a href="{{ '/feed.xml' | relative_url }}">via RSS</a></p>
