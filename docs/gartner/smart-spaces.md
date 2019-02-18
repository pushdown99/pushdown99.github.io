---
description: >
  This chapter shows how to upgrade Hydejack to a newer version. The method depends on how you've installed Hydejack.
hide_description: true
---

# 스마트 공간(Smart Spaces)
스마트 홈, 스마트 시티를 포함한 자동화된 공간을 말한다. 위에서 언급한 블록체인, 엣지 컴퓨팅, IoT 등이 모두 발전해야 이룰 수 있는 단계다. 자율주행, 업무 자동화 등을 위해 스마트 시티, 디지털 작업 공간(몰입형 경험), 스마트 홈, 커넥티드 공장 등이 발달하고, 또 이 요소들끼리 융합해 자동화를 이루는 것을 말한다. 예를 들어, 직원은 가장 가까운 주차 공간으로 안내하기 위해 앱을 사용할 수 있으며, 건물에 들어가면 작업 공간과 회의실을 할당받을 수 있다. 동시에 그의 ‘스마트 배지’는 안전을 위해 자신의 위치를 ​​추적할 수 있도록 한다. 생활편의 외에도 SaaS, 인력관리, IT 서비스 괸리, 금융, 세일즈, 마케팅 부문 자동화 등을 통합해 언급하는 개념이다.

## Table of Contents
{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}

**NOTE**: Before upgrading to v7+, make sure you've read the [CHANGELOG](../CHANGELOG.md){:.heading.flip-title},
especially the part about the [license change](../CHANGELOG.md#license-change)!
{:.message}

## Via Starter Kit
When using the Starter Kit, upgrading Hydejack is as simple as setting the `remote_theme` key in `config.yml` to the desired version.

```yml
remote_theme: qwtel/hydejack@v8.2.0
```

To use the latest version on the `v8` branch on each build, you can use  `qwtel/hydejack@v8`.


## Via gem
Upgrading the the gem-based theme is as easy as running

```bash
bundle update jekyll-theme-hydejack
```

## Via zip
Upgrading via zip is a bit of a dark art, specially if you've made changes to any source files,
and the prime reason why I suggest using the gem-based version of the theme.

Generally, you'll want to copy these files and folders:

* `_includes/`
* `_layouts/`
* `_sass/`
* `assets/`
* `Gemfile`
* `Gemfile.lock`

and merge them with your existing folder. However, you'll also want to check out `_data` and `_config.yml` for any changes
and read latest entries to the [CHANGELOG](../CHANGELOG.md){:.heading.flip-title}.

**NOTE**: If you've modified any of Hydejack's internal files, your changes will most likely be overwritten
and you have to apply them again.
Make sure you've made a backup before overwriting any files.
{:.message}


## Via git
The latest version sits on the `master` branch of [qwtel/hydejack](https://github.com/qwtel/hydejack).
To apply them to your repository run

~~~bash
$ git remote add hydejack git@github.com:qwtel/hydejack.git
$ git pull hydejack master
~~~


## PRO Version
Buyers of the PRO version will find the files necessary for an upgrade in the `upgrade` folder of the downloaded zip archive.

**NOTE**: If you've modified any of Hydejack's internal files, your changes will most likely be overwritten
and you have to apply them again.
Make sure you've made a backup before overwriting any files.
{:.message}


### PRO via GitHub (advanced)
If you've followed the steps [here](install.md#pro-via-github-advanced), all you need to upgrade is:

~~~bash
$ bundle update jekyll-theme-hydejack-pro
~~~


Continue with [Config](config.md){:.heading.flip-title}
{:.read-more}
