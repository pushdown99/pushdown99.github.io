---
description: >
  There are multiple ways of installing Hydejack and this document lays them out for you. The easiest way is with the Hydejack Starter Kit.
hide_description: true
---

# 디지털 쌍둥이(Digital Twins)
디지털 쌍둥이는 현존하는 것들의 디지털 복제품을 말한다. 건축물의 CAD 도면이라고 생각하면 쉽다. 디지털 쌍둥이가 필요한 이유는 IoT(Internet of Things) 효율성 때문이다. 디지털 쌍둥이를 구현해놓고 이 위에서 시뮬레이션을 진행하면 효과적인 결과를 내놓는다는 것이다. 가트너 예측에 따르면 2020년까지 200억 개 이상의 IoT 센서 및 제품이 등장할 것이다. 이를 효율적으로 통제하기 위해 디지털 쌍둥이를 구현해야 하며, 그 구현을 더욱 쉽게 하는 소프트웨어들이 등장해야 한다고 본다. 따라서 3D 모델링의 표준화 및 단순화, 교육 강화 등이 필요하다는 주장이다.

Buyers of the PRO version should [follow these steps](#pro-version).

## Table of Contents
{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}

## Via Starter Kit
Using the Starter Kit has the advantage of not cluttering your blog repository.
Additionally, it allows you to publish your site on GitHub Pages with a single `push`.

If you have a GitHub account, fork the [hy-starter-kit](https://github.com/qwtel/hy-starter-kit) repository. Otherwise [download the source files][src] and unzip them somewhere on your machine.

**NOTE**: In addition to the docs here, you can follow the quick start guide in the Starter Kit.
{:.message}

`cd` into the directory where `_config.yml` is located and follow the steps in [Running locally](#running-locally).

Alternatively, you can just [![Deploy to Netlify][dtn]{:data-ignore=""}][nfy]{:.no-hover.no-mark}.

[src]: https://github.com/qwtel/hy-starter-kit/archive/v8.2.0.zip
[nfy]: https://app.netlify.com/start/deploy?repository=https://github.com/qwtel/hydejack-starter-kit
[dtn]: https://www.netlify.com/img/deploy/button.svg

## Via gem
Jekyll has [built-in support](https://jekyllrb.com/docs/themes/) for using themes that are hosted on RubyGems.  

If you haven't already, create a new Jekyll site first:

~~~bash
$ jekyll new <PATH>
~~~

Your site's root dir should look something like this

~~~
├── _posts
│   └── 2017-04-07-welcome-to-jekyll.markdown
├── _config.yml
├── about.md
├── Gemfile
├── Gemfile.lock
└── index.md
~~~

**NOTE**: Hydejack works with Jekyll's default `config.yml`, but it is recommended that you replace it with
[Hydejack's default config file](https://github.com/qwtel/hydejack/blob/v8/_config.yml).
It contains the names of all config options known to Hydejack and provides sensible defaults (like minifying HTML and CSS in production builds).
{:.message}

Next, you'll want to add `jekyll-theme-hydejack` as a dependency by adding the following line to the `Gemfile`.

~~~ruby
gem "jekyll-theme-hydejack"
~~~

(You can also remove the old theme `jekyll-theme-minima` from the Gemfile)

Now you want to edit the `_config.yml` of your Jekyll site and set Hydejack as the theme.
Look for the `theme` key and set its value to `jekyll-theme-hydejack`.

~~~yml
theme: jekyll-theme-hydejack
~~~

For more information on gem-based themes, see the [Jekyll Documentation](http://jekyllrb.com/docs/themes/).

You can now continue with [running locally](#running-locally).

## Via zip
If you downloaded the [extended zip](https://github.com/qwtel/hydejack/releases),
extract the contents somewhere on your machine.
The high-level folder structure will look something like.

~~~
├── _data
├── _featured_categories
├── _featured_tags
├── _includes
├── _js
├── _layouts
├── _posts
├── _sass
├── assets
├── _config.yml
├── 404.md
├── about.md
├── index.html
└── posts.md
~~~

`cd` into the directory where `_config.yml` is located and follow the steps in [Running locally](#running-locally).

## Via git
If you are familiar with using git, you can add the [Hydejack repository](https://github.com/qwtel/hydejack)
as a remote, and merge its master branch into your working branch.

~~~bash
$ git remote add hydejack git@github.com:qwtel/hydejack.git
$ git pull hydejack master
~~~

You can also update Hydejack this way. The master branch will not contain work in progress,
but will contain major (breaking) changes.
This approach is recommended if you intend to customize Hydejack.

You can now continue with [running locally](#running-locally).

## PRO Version
If you bought the PRO version, you've received a zip archive with the following contents:

~~~
├── install
├── upgrade
├── CHANGELOG.pdf
├── Documentation.pdf
├── NOTICE.pdf
├── PRO License.pdf
├── PRO–hy-drawer License.pdf
├── PRO–hy-img License.pdf
├── PRO–hy-push-state License.pdf
└── .ssh
~~~

`install`
: Contains all files and folders needed to create a new blog.

`upgrade`
: Contains only the files and folders needed for upgrading form an earlier version of Hydejack (6.0.0 or above). See [Upgrade]{:.heading.flip-title} for more.

`.ssh`
: A hidden folder containing a SSH key for read-only access to the Hydejack PRO GitHub repository.
  You can use this to install Hydejack PRO as gem-based theme.
  See the [installation instructions](#pro-via-github-advanced) below.
  This is for advanced users.

For new installations only the `install` folder is relevant.
Unzip the archive somewhere on your machine, then `cd` *into* the `install` folder, e.g.

~~~bash
$ cd ~/Downloads/hydejack-pro-8.2.0/install/
~~~

You can now continue with [Running locally](#running-locally).

### PRO via GitHub (advanced)
If you know how to handle SSH keys, you can also install the PRO version as a gem-based theme via GitHub.
The advantage of this method is that you avoid cluttering your Jekyll repository with Hydejack's source files.

The downloaded zip contains a read-only key for a private GitHub repository.
It is located at `<dowloaded zip>/.ssh/hydejack_8_pro`.
You have to copy the key file to `~/.ssh` (or wherever your SSH keys are located), e.g.:

~~~bash
$ cp ~/Downloads/hydejack-pro-8.2.0/.ssh/hydejack_8_pro ~/.ssh/
~~~

It is required that your private key files are NOT accessible by others, e.g.:

~~~bash
$ chmod 600 ~/.ssh/hydejack_8_pro
~~~

Then add the following to `.ssh/config`:

~~~
Host hydejack
	HostName github.com
	IdentitiesOnly yes
	IdentityFile ~/.ssh/hydejack_8_pro
~~~

Next, open `Gemfile` in your Jekyll repository and add:

~~~ruby
gem "jekyll-theme-hydejack-pro", git: 'git@hydejack:qwtel/hydejack-8-pro.git'
~~~

In your `_config.yml`, add:

~~~yml
theme: jekyll-theme-hydejack-pro
~~~

You can now continue with [Running locally](#running-locally).

## Running locally
Make sure you've `cd`ed into the directory where `_config.yml` is located.
Before running for the first time, dependencies need to be fetched from [RubyGems](https://rubygems.org/):

~~~bash
$ bundle install
~~~

**NOTE**: If you are missing the `bundle` command, you can install Bundler by running `gem install bundler`.
{:.message}

Now you can run Jekyll on your local machine:

~~~bash
$ bundle exec jekyll serve
~~~

and point your browser to <http://localhost:4000> to see Hydejack in action.


Continue with [Config](config.md){:.heading.flip-title}
{:.read-more}


[upgrade]: upgrade.md
