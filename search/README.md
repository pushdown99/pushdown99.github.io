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
  {% for post in posts %}
    <div class="post-item">
      {% assign date_format = date_format | default: "%b %-d, %Y" %}
      <span class="post-meta">{{ post.date | date: date_format }}</span>
      <h2>
        <a class="post-link" href="{{ post.url | relative_url }}">
          {{ post.title | escape }}
        </a>
      </h2>
      <div class="post-snippet">{{ post.excerpt }}</div>
    </div>
  {% endfor %}
</div>
{% include algolia.html %}

<p class="rss-subscribe">subscribe <a href="{{ '/feed.xml' | relative_url }}">via RSS</a></p>
