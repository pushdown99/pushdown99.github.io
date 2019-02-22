---
description: >
  This chapter shows how to upgrade Hydejack to a newer version. The method depends on how you've installed Hydejack.
hide_description: true
---

# Blockchain
A blockchain,[^1][^2][^3] originally block chain,[^4][^5] is a growing list of records, called blocks, which are linked using cryptography.[^1][^6] Each block contains a cryptographic hash of the previous block,[^6] a timestamp, and transaction data (generally represented as a merkle tree root hash).

By design, a blockchain is resistant to modification of the data. It is "an open, distributed ledger that can record transactions between two parties efficiently and in a verifiable and permanent way".[^7] For use as a distributed ledger, a blockchain is typically managed by a peer-to-peer network collectively adhering to a protocol for inter-node communication and validating new blocks. Once recorded, the data in any given block cannot be altered retroactively without alteration of all subsequent blocks, which requires consensus of the network majority. Although blockchain records are not unalterable, blockchains may be considered secure by design and exemplify a distributed computing system with high Byzantine fault tolerance. Decentralized consensus has therefore been claimed with a blockchain.[^8]

Blockchain was invented by a person using the name **Satoshi Nakamoto** in 2008 to serve as the public transaction ledger of the cryptocurrency bitcoin.[^1] The identity of Satoshi Nakamoto is unknown. The invention of the blockchain for bitcoin made it the first digital currency to solve the double-spending problem without the need of a trusted authority or central server. The bitcoin design has inspired other applications,[^1][^3] and blockchains which are readable by the public are widely used by cryptocurrencies. Blockchain is considered a type of payment rail.[^9] Private blockchains have been proposed for business use. Sources such as Computerworld called the marketing of such blockchains without a proper security model "snake oil".[^10] [`wiki`](https://en.wikipedia.org/wiki/Blockchain)

블록체인(영어: block chain, blockchain)은 관리 대상 데이터를 '블록'이라고 하는 소규모 데이터들이 P2P 방식을 기반으로 생성된 체인 형태의 연결고리 기반 분산 데이터 저장환경에 저장되어 누구라도 임의로 수정할 수 없고 누구나 변경의 결과를 열람할 수 있는 분산 컴퓨팅 기술 기반의 데이터 대변 방지 기술이다. 이는 근본적으로 분산 데이터 저장기술의 한 형태로, 지속적으로 변경되는 데이터를 모든 참여 노드에 기록한 변경 리스트로서 분산 노드의 운영자에 의한 임의 조작이 불가능하도록 고안되었다. 블록체인 기술은 비트코인을 비롯한 대부분의 암호화폐 거래에 사용된다. 암호화폐의 거래과정은 탈중앙화된 전자장부에 쓰이기 때문에 블록체인 소프트웨어를 실행하는 많은 사용자들의 각 컴퓨터에서 서버가 운영되어 중앙은행 없이 개인 간의 자유로운 거래가 가능하다. [`wiki`](https://ko.wikipedia.org/wiki/%EB%B8%94%EB%A1%9D%EC%B2%B4%EC%9D%B8)
블록체인은 분산원장(distributed ledger)의 일종이다. 정보전달을 블록을 생성해 하고, 뒤의 블록이 앞의 블록의 정보가 맞는지 끊임없이 검증하는 모델이므로 신뢰 구축, 투명성 제공, 비용 절감, 거래 합의 시간 단축, 현금 흐름 개선 등의 효과가 있다.
그러나 현재의 블록체인 기업들은 블록체인의 이념적 특성(탈중앙화)을 구현하기엔 기술이 부족하다. 블록체인이 등장한 지 시간이 얼마 되지 않아 기술 고도화가 덜 이뤄진 탓이다. 이 기술이 점차 고도화되면 기업 간 계약이나 정부의 신뢰성 검증, 탈중앙화의 이념에 가까워질 것이다. 이미 블록체인을 성공적으로 도입한 정부도 있으며, (코인을 제외하고)블록체인을 사업화하고 있는 사례도 있다. 미래에 대한 다양한 시나리오도 준비돼 있다.
{:.message}

{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}
![Screenshot](/assets/img/docs/blockchain.png)

## Blockchain
https://d2fault.github.io/categories/IT/Blockchain/page/3/

[^1]: "Blockchains: The great chain of being sure about things". The Economist. 31 October 2015. Archived from the original on 3 July 2016. Retrieved 18 June 2016. The technology behind bitcoin lets people who do not know or trust each other build a dependable ledger. This has implications far beyond the crypto currency.
[^2]: Morris, David Z. (15 May 2016). "Leaderless, Blockchain-Based Venture Capital Fund Raises $100 Million, And Counting". Fortune. Archived from the original on 21 May 2016. Retrieved 23 May 2016.
[^3]: Popper, Nathan (21 May 2016). "A Venture Fund With Plenty of Virtual Capital, but No Capitalist". The New York Times. Archived from the original on 22 May 2016. Retrieved 23 May 2016.
[^4]: Brito, Jerry; Castillo, Andrea (2013). Bitcoin: A Primer for Policymakers (PDF) (Report). Fairfax, VA: Mercatus Center, George Mason University. Archived (PDF) from the original on 21 September 2013. Retrieved 22 October 2013.
[^5]: Trottier, Leo (18 June 2016). "original-bitcoin" (self-published code collection). github. Archived from the original on 17 April 2016. Retrieved 18 June 2016. This is a historical repository of Satoshi Nakamoto's original bit coin sourcecode
[^6]: Narayanan, Arvind; Bonneau, Joseph; Felten, Edward; Miller, Andrew; Goldfeder, Steven (2016). Bitcoin and cryptocurrency technologies: a comprehensive introduction. Princeton: Princeton University Press. ISBN 978-0-691-17169-2.
[^7]: Iansiti, Marco; Lakhani, Karim R. (January 2017). "The Truth About Blockchain". Harvard Business Review. Harvard University. Archived from the original on 18 January 2017. Retrieved 17 January 2017. The technology at the heart of bitcoin and other virtual currencies, blockchain is an open, distributed ledger that can record transactions between two parties efficiently and in a verifiable and permanent way.
[^8]: Raval, Siraj (2016). "What Is a Decentralized Application?". Decentralized Applications: Harnessing Bitcoin's Blockchain Technology. O'Reilly Media, Inc. pp. 1–2. ISBN 978-1-4919-2452-5. OCLC 968277125. Retrieved 6 November 2016 – via Google Books.
[^9]: "Blockchain may finally disrupt payments from Micropayments to credit cards to SWIFT". dailyfintech.com. 2018-02-10. Retrieved 2018-11-18.
[^10]: Hampton, Nikolai (5 September 2016). "Understanding the blockchain hype: Why much of it is nothing more than snake oil and spin". Computerworld. Archived from the original on 6 September 2016. Retrieved 5 September 2016.