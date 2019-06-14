---
layout: post
title: 'Blockchain-Vote' 
author: haeyeon.hwang
tags: [blockchain]
image: /assets/img/blog/hackathon.png
hide_image: true
---

{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}

##  virtual box ubuntu 설치
 - 메모리 고정크기로 설치
  (동적할당으로 설치 시 실제 설정한 용량 데이터 저장이 안되는 경우가 있어서,
   개인적으로 고정크기 설치를 선호합니다.)
 - 10gb시 device 용량 부족 에러 호출로 20gb로 설치 진행
 - 설치 시 언어는 영어로 진행

## install node js
: 패키지 인스톨 진행
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs

## install ubuntu-desktop
: Node 등을 윈도우나 맥 os에서 실행하실거면 굳이 우분투에서 해당 앱 예제를 실행하지 않으셔도 됩니다.
기존에 Ubuntu에 모두 설치한 줄 알고, GUI만 추가하려한 것이 당초 의도입니다.
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install ubuntu-desktop
startx : 재시작 / 이때 재시작은 putty가 아닌 ubuntu console에서 실행
* 기존에 desktop 설치 에러 나신 분들, 용량 부족 여부 확인하셔서 진행하시면 좋을 것 같습니다.
startx로 재시작 후 화면이 제대로 나오지 않는다면,
우분투 종료 후 재시작 (저는 종료 시 상태 저장을 하지 않습니다.)

## 소스 저장할 경로 생성
cd Desktop/
mkdir webdapp
cd webdapp

## filezilla
프로토콜 : sftp
로그인 유형 : 일반

## 소스코드 복사
파일질라 사용 안하고 CLI에서 복사하셔도 됩니다.
투표웹 소스에 node_module이 포함되어 있는데,
삭제후 npm install로 저설치 하셔야 합니다.

*아래 코드는 webdapp 경로 안에서 실행합니다.
## 1번째 Putty 에서 ganache-cli 실행
 node_modules/.bin/ganache-cli

## 2번째 putty 에서 Voting.sol 컴파일 
node를 타이핑하여 노드 콘솔 실행
In the node console
> code = fs.readFileSync('Voting.sol').toString()
> solc = require('solc')
> compiledCode = solc.compile(code)
> Web3 = require('web3')
> web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
> abiDefinition = JSON.parse(compiledCode.contracts[':Voting'].interface)
> VotingContract = web3.eth.contract(abiDefinition)
> byteCode = compiledCode.contracts[':Voting'].bytecode
> deployedContract = VotingContract.new(['dog','cat','gozila'],{data: byteCode, from: web3.eth.accounts[0], gas: 4700000})
> deployedContract.address
> deployedContract.totalVotesFor.call('dog')
> deployedContract.voteForCandidate('dog', {from: web3.eth.accounts[0]})
> deployedContract.voteForCandidate('dog', {from: web3.eth.accounts[0]})
> deployedContract.voteForCandidate('dog', {from: web3.eth.accounts[0]})
> deployedContract.totalVotesFor.call('dog').toLocaleString()

## deployedContract.address로 호출한 address를 index.js의 아래코드에서 주소값 입력
 contractInstance = VotingContract.at('0xffc06b6be6a5babfa1d4430558c89d90d1651697');
 이후 다시 filezilla등으로 index.js 파일 업데이트

## putty가 아닌 우분투 터미널 실행하여 http-server실행
sudo npm install -g http-server
http-server
실행되는 ip주소 컨트롤+클릭으로 투표 앱 확인


