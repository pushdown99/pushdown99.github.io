---
layout: post
title: '분자구조' 
author: haeyeon.hwang
tags: [visualization, chart, stock, finance, javascript]
description: >
  분자 내의 원자 배치와 그것들 사이의 화학 결합 상태이다. 또는 분자 중의 원자간 결합 거리와 결합각 등을 고려한 3차원 입체구조이다. 하지만 분자의 개략적인 형태를 정성적으로 생각해서 그것을 분자구조라고 하는 경우도 있다. 예를 들면 물 분자는 사면체 분자구조이고 암모니아는 피라미드형 분자구조이다. 주로 원자가에 의한 구조식이 사용된다.  [`사이언스올`](https://www.scienceall.com/)
image: /assets/img/blog/chemical-structure.jpg
hide_image: true
---

{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

## **분자구조식**

---

#### 그려주는 패키지

- [chemfig](https://ctan.org/pkg/chemfig)
- [ochem](https://ctan.org/pkg/ochem)
- [streeTeX](https://ctan.org/pkg/streetex)
- [XyMTeX](https://ctan.org/pkg/xymtex)
- [PPCHTeX](https://wiki.contextgarden.net/Chemistry)

### LaTex Math Symbols

#### Math Mode Accents

-|LaTeX|-|LaTeX|-|LaTeX|-|LaTeX
---|---|---|---|---|---|---|---
$$\hat{a}$$ | \hat{a} | $$\check{a}$$ | \check{a} | $$\tilde{a}$$ | \tilde{a} | $$\acute{a}$$ | \acute{a} 
$$\grave{a}$$ | \grave{a} | $$\dot{a}$$ | \dot{a} | $$\ddot{a}$$ | \ddot{a} | $$\breve{a}$$ | \breve{a} 
$$\bar{a}$$ | \bar{a} | $$\vec{a}$$ | \vec{a} | $$\widehat{A}$$ | \widehat{A} | $$\widetilde{A}$$ | \widetilde{A} 

$$\\
\xleftarrow{{}} \\
\leftarrow \\ $$

$$e^{ix} = \cos{x} + i\sin{x}$$
$$C_2H_5OH \rightarrow CH$$

$$\hat{a}$$
$$\check{a}$$


$$Y=W{x}+b$$

```plantuml
@startuml Diagram
actor client
node app
database db
db -> app
app -> client
@enduml
```