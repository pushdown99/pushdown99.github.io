---
description: >
  There are two ways of adding third party scripts.
  Embedding is ideal for one-off scripts, while global scripts are loaded on every page.
hide_description: true
---

# 몰입 경험(Immersive Experience)
AR, VR, MR 기술들의 사용자 경험을 말한다. 단순히 AR로 경험을 하는 것을 말하는 게 아니라 AI에 의해 향상될 경험을 예측한다. AI를 통해 더욱 자연스럽게 발전할 자연어 처리나 음성인식 등이 몰입형 경험에 좋은 영향을 미칠 것으로 가트너는 내다봤다. 단순히 영화를 보거나 시간을 때우는 것을 넘어, AR을 통한 교육이나 가구 조립, 창작 활동에 도움이 될 수 있다. 예를 들어 가구를 조립할 떄 부품이 잘 맞는지 등을 AI에게 질문하면 AI가 도움을 주는 식이다.

또한, 가트너는 몰입형 경험이 자동차 등의 엣지에도 도입될 것으로 내다봤는데, 이 경우 클라우드로 데이터를 처리하면 사고 등의 문제가 생길 수 있으므로, 로컬 컴퓨팅 성능을 끌어올리는 것을 권했다.

시간이 지나면 이러한 몰입형 경험은 AR 헤드셋을 벗고 실제 환경에서 이뤄질 것이다. 가트너의 데이비드 설리 부사장은 “시간이 지나면서 (중략) 다중 채널 경험은 모든 인간의 감각을 이용할 뿐만 아니라 다중 모드 디바이스의 고급 컴퓨터 감각(열, 습도, 레이더 등)을 모두 활용할 것이다. 이러한 다중 경험 환경은 개별 장치가 아닌 우리를 둘러싼 공간이 ‘컴퓨터’를 정의하게 되는 앰비언트 경험(ambient experience)을 제공할 것”이라고 했다. 시각뿐 아니라 컴퓨터가 온도나 습도 등을 모두 체크하며 환경 전체를 AR 도구로 쓰게 될 것임을 암시하는 것이다.

## Table of Contents
{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}

## Embedding
Hydejack supports embedding third party scripts directly inside markdown content. This will work in most cases, except when a script can not be loaded on a page more than once (this will occur when a user navigates to the same page twice).

Example:

~~~html
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
<blockquote class="twitter-tweet" data-lang="en">
  <p lang="en" dir="ltr">
    The next version of Hydejack (v6.3.0) will allow embedding 3rd party scripts,
    like the one that comes with this tweet for example.
  </p>
  &mdash; Florian Klampfer (@qwtel)
  <a href="https://twitter.com/qwtel/status/871098943505039362">June 3, 2017</a>
</blockquote>
~~~

<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">The next version of Hydejack (v6.3.0) will allow embedding 3rd party scripts, like the one that comes with this tweet for example.</p>&mdash; Florian Klampfer (@qwtel) <a href="https://twitter.com/qwtel/status/871098943505039362">June 3, 2017</a></blockquote>

## Global scripts
If you have scripts that should be included on every page you can add them globally by
opening (or creating) `_includes/my-scripts.html` and adding them like you normally would:

```html
<!-- file: _includes/my-scripts.html -->
<script
  src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
  integrity="sha256-k2WSCIexGzOj3Euiig+TlR8gA0EmPjuc79OEeY5L45g="
  crossorigin="anonymous"></script>
```

`my-scripts.html` will be included at the end of the `body` tag.

## Registering push state event listeners
When embedding scripts globally you might want to run some init code after each page load. However, the problem with push state-based page loads is that the `load` event won't fire again. Luckily, Hydejack's push state component exposes an event that you can listen to instead.

```html
<!-- file: _includes/my-scripts.html -->
<script>
  document.getElementsByTagName('hy-push-state')[0].addEventListener('hy-push-state-load', function() {
    // <your init code>
  });
</script>
```

Note that the above code must only run once, so include it in your `my-scripts.html`.

`hy-push-state-start`
: Occurs after clicking a link.

`hy-push-state-ready`
: Animation fished and response has been parsed, ready to swap out the content.

`hy-push-state-after`
: The old content has been replaced with the new content.

`hy-push-state-progress`
: Special case when animation is finished, but no response from server has arrived yet.
  This is when the loading spinner will appear.

`hy-push-state-load`
: All embedded script tags have been inserted into the document and have finished loading.

## If everything else fails
If you can't make an external script work with Hydejack's push state approach to page loading,
you can disable push state by adding to your config file:

```yml
# file: _config.yml
hydejack:
  no_push_state: true
```


Continue with [Build](build.md){:.heading.flip-title}
{:.read-more}
