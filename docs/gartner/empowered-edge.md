---
description: >
  This documents shows how to upgrade Hydejack from previous versions (v5) in a step-by-step manner.
hide_description: true
---

# 자율권을 가진 엣지(Empowered Edge)
가트너가 엣지라고 표현하는 것은 사용자 근처에 있는 기기들을 말한다. 이 엣지들이 컴퓨팅하는 것을 엣지 컴퓨팅이라고 말한다. 클라우드 컴퓨팅과 일부 상충하는 개념이다. 기기 근처에서 처리되므로 온디바이스 컴퓨팅과 유사하나 그 기기 안에서가 아니라 그 근처에서 처리돼도 되므로 범위가 조금 다르다. 대표적인 엣지 컴퓨팅 기기는 자율주행차다. 자율주행차는 실제 도로 주행 시 클라우드에 정보를 보내지 않아도 응급 상황 시 스스로 대처해야 한다. 따라서 통신을 통해 모든 것을 처리하면 안 된다. 물론 클라우드 컴퓨팅 스타일의 자율주행차도 있다. 경기도의 자율주행 버스 제로 셔틀이 서버에서 오는 신호를 활용한다.
 
가트너가 엣지 컴퓨팅을 주장하는 이유는 IoT 제품 때문이다. 사람의 행동, 날씨 등에 민감하게 대응해야 하는 IoT 제품류는 트래픽이나 지연 시간을 줄이기 위해 프로세싱을 로컬에서 처리하려고 하는 것이다. 클라우드와 완전히 상충된 개념은 아닌데, 중앙화된 클라우드는 아니지만 엣지를 클라우드로 생각할 수도 있기 때문. 가트너는 5G 상용화가 이뤄지면 클라우드-엣지 컴퓨팅이 서로 보완하는 모델이 등장할 것으로 내다봤다. 엣지 컴퓨팅은 향후 5년간 다양한 AI 칩이 등장하며 활성화될 것이다.

## Table of Contents
{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}

## From v5
### Updating the folder structure
Copy the the following folders and files from Hydejack v6 into your existing repository. Make sure you merge the folder contents.

* `_data/`
* `_includes/`
* `_layouts/`
* `_sass/`
* `assets/`
* `index.html` (`index.md`\*)
* `Gemfile`
* `Gemfile.lock`

Note that the `public` folder has been renamed to `assets`.
You'll want to move your static assets there.

### Updating the configuration
`_config.yml` has changed considerably. Open it and make the following changes.

1.  Rename the following keys

    * `font_accent` => `font_heading`
    * `load_google_fonts` => `google_fonts`
    * `google_analytics_id` => `google_analytics`

2.  Enable Jekyll Collections for categories and tags by adding

    ~~~yml
    collections:
      featured_categories:
        permalink: /category/:name/
        output:    true
      featured_tags:
        permalink: /tag/:name/
        output:    true
    ~~~

3.  Delete `photo` and `photo2x` form the author key and add a `picture` hash instead that looks like

    ~~~yml
    picture:
      path: <photo>
      srcset:
        1x: <photo>
        2x: <photo2x>
    ~~~

    If you have only one photo, you can just provide the URL directly, e.g. `picture: <url>`.

    For more information, see [Adding an author](config.md#adding-an-author).

4.  Rename `gems` to `plugins` and make sure the list contains `jekyll-seo-tag`.

    ~~~yml
    plugins:
      - jekyll-seo-tag
    ~~~


**NOTE**: When making changes to `_config.yml`, it is necessary to restart the Jekyll process for the changes to take effect.
{:.message}


### Restoring the tags
1.  Delete the `tag` folder.
2.  Create a top-level folder called `_featured_tags`.
3.  For each entry in `_data/tags.yml`, create a markdown file in `_features_tags` with the name of the tag as filename,
    e.g. `hyde.md` for tag "hyde".
4.  For each tag, copy its contents from `_data/tags.yml` into the new file's front matter, e.g.

    ~~~yml
    ---
    layout: list
    name: Hyde
    description: >
      Hyde is a brazen two-column Jekyll theme...
    accent_image: /hydejack/public/img/hyde.jpg
    accent_color: '#949667'
    ---
    ~~~

    Be aware that `image` has been renamed to `accent_image` and `color` has been renamed to `accent_color`.

5. Add `layout: list` to the front matter.
6. Once you've copied all tags into their own files, delete `_data/tags.yml`.

### Restoring the sidebar entries
Hydejack can now link to any kind of page in the sidebar.

1. Delete `sidebar_tags` in `_config.yml`.
2. Open a file who's page you would like to add to the sidebar. If you want to add a tag, open `_featured_tags/<tagname>.md`.
3. Add `menu: true` to its front matter.
4. (Optional) Set `order: <number>`, where `<number>` is the number at which you would like the link to appear.

### Restoring the RSS feed
The feed is now provided by the `jekyll-feed` plugin instead of a custom solution.

1.  Delete `atom.xml`
2.  Add `- jekyll-feed` to `gems` in `_config.yml`, e.g.

    ~~~yml
    gems:
      - jekyll-seo-tag
      - jekyll-feed
    ~~~

3.  (Optional) Add the following to `_config.yml` to make the feed appear at the same URL as the old `atom.xml`.

    ~~~yml
    feed:
      path: atom.xml
    ~~~

### Restoring the comments
The way comments are enabled has changed slightly.
You now have to enable them per page by adding `comments: true` to the front matter
(this is what the [Disqus integration guide](https://disqus.com/admin/install/platforms/jekyll/) suggests).
To enable them for all posts, add to the config file

```yml
defaults:
  - scope:
      type: posts
    values:
      comments: true
```

### Restoring the about page
Hydejack now has a dedicated layout for about pages.
To use it, open `about.md` and change the `layout` in the front matter to `about`
and delete `{\% include about-short.html author=site.author %\}`.
