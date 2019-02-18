---
description: >
  This chapters shows how to prepare your Hydejack site for a production build and deployment on 3rd party hosting providers.
hide_description: true
---

# 블록체인(Blockchain)
블록체인은 분산원장(distributed ledger)의 일종이다. 정보전달을 블록을 생성해 하고, 뒤의 블록이 앞의 블록의 정보가 맞는지 끊임없이 검증하는 모델이므로 신뢰 구축, 투명성 제공, 비용 절감, 거래 합의 시간 단축, 현금 흐름 개선 등의 효과가 있다.

그러나 현재의 블록체인 기업들은 블록체인의 이념적 특성(탈중앙화)을 구현하기엔 기술이 부족하다. 블록체인이 등장한 지 시간이 얼마 되지 않아 기술 고도화가 덜 이뤄진 탓이다. 이 기술이 점차 고도화되면 기업 간 계약이나 정부의 신뢰성 검증, 탈중앙화의 이념에 가까워질 것이다. 이미 블록체인을 성공적으로 도입한 정부도 있으며, (코인을 제외하고)블록체인을 사업화하고 있는 사례도 있다. 미래에 대한 다양한 시나리오도 준비돼 있다.

## Table of Contents
{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}

## Starter Kit
If you're using the [starter kit](install.md#via-starter-kit), all you have to do is push your repository:

```bash
$ git add .
$ git commit "Update"
$ git push origin master
```

## Preparation

Before building, make sure the following is part of your config file:

```yml
# file: _config.yml
compress_html:
  comments:  ["<!-- ", " -->"]
  clippings: all
  endings:   all

sass:
  style:     compressed
```

You can check out [jekyll-compress-html](https://github.com/penibelst/jekyll-compress-html) and
<https://jekyllrb.com/docs/assets/#sassscss> for details.

## Building locally
When building Hydejack it is important to set the environment variable `JEKYLL_ENV` to `production`.
Otherwise the output will not be minified. Building itself happens via Jekyll's `build` command.

~~~bash
$ JEKYLL_ENV=production bundle exec jekyll build
~~~

This will generate the finished static files in `_site`,
which can be deployed using the methods outlined in the [Jekyll Documentation][deploy].


## Building locally with latent semantic analysis
By default, related posts are simply the most recent posts.
Hydejack modifies this a bit, by showing the most recent posts of the same category or tag.
However, the results are still pretty "unrelated".
To provide better results, Jekyll supports [latent semantic analysis][lsa] via [`classifier-reborn`][crb]'s
[Latent Semantic Indexer][lsi]

To use the LSI, you first have to disable Hydejack's default behavior,
by setting `use_lsi: true` under the `hydejack` key in your config file.

~~~yml
# file: _config.yml
hydejack:
  use_lsi: true
~~~

Then, you have to run `jekyll build` with the `--lsi` flag:

~~~bash
$ JEKYLL_ENV=production bundle exec jekyll build --lsi
~~~


Note that this may take a long time.
Once it is finished, the generated static files will be located in the `_site` directory,
which can be deployed using the methods outlined in the [Jekyll Documentation][deploy].


## GitHub Pages
To deploy to GitHub Pages, the steps are:

~~~bash
$ cd _site
$ git init # you only need to do this once
$ git remote add origin <github_remote_url> # you only need to do this once
$ git add .
$ git commit -m "Build"
$ git push origin master:<remote_branch>
$ cd ..
~~~

`github_remote_url`
: Find this on your repository's GitHub page.

`remote_branch`
: Either `master` for "user or organization pages", or `gh-pages` for "project pages"

More on [user, organization, and project pages](https://help.github.com/articles/user-organization-and-project-pages/).


Continue with [Advanced](advanced.md){:.heading.flip-title}
{:.read-more}

[deploy]: https://jekyllrb.com/docs/deployment-methods/
[lsa]: https://en.wikipedia.org/wiki/Latent_semantic_analysis
[crb]: http://www.classifier-reborn.com/
[lsi]: http://www.classifier-reborn.com/lsi

*[LSI]: Latent Semantic Indexer
