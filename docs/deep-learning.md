---
description: >
  This chapter shows how to upgrade Hydejack to a newer version. The method depends on how you've installed Hydejack.
hide_description: true
---

# Deep Learning
Deep learning (also known as deep structured learning or hierarchical learning) is part of a broader family of machine learning methods based on learning data representations, as opposed to task-specific algorithms. Learning can be supervised, semi-supervised or unsupervised.[^1][^2][^3]

Deep learning architectures such as deep neural networks, deep belief networks and recurrent neural networks have been applied to fields including computer vision, speech recognition, natural language processing, audio recognition, social network filtering, machine translation, bioinformatics, drug design, medical image analysis, material inspection and board game programs, where they have produced results comparable to and in some cases superior to human experts.[^4][^5][^6]

Deep learning models are vaguely inspired by information processing and communication patterns in biological nervous systems yet have various differences from the structural and functional properties of biological brains (especially human brains), which make them incompatible with neuroscience evidences.[^7][^8][^9]

{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}
![Screenshot](/assets/img/docs/deep_learning.png){: width="300"}

## Installation
### Python Installation
1. 파이썬 설치: 3.6.8 버전(64비트)  
  https://www.python.org/ftp/python/3.6.8/python-3.6.8-amd64.exe
2. 파이썬/텐서플로우 설치  
  https://www.tensorflow.org/install/pip 
```console
C:\> pip install -U pip virtualenv
C:\> virtualenv --system-site-packages -p python ./venv
(venv) C:\> .\venv\Scripts\activate
(venv) C:\> pip install –upgrade pip
(venv) C:\> pip list
(venv) C:\> pip install –upgrade tensorflow
(venv) C:\> pip install matplotlib pillow
(venv) C:\> deactivate
```

3. git 설치
```console
https://git-scm.com/download/win
Git-2.20.1-64-bit.exe 설치
```   
4. 소스코드 다운로드
```console
(venv) C:\> git clone https://github.com/golbin/TensorFlow-Tutorials.git
```
5. 주피터 노트북 설치 및 실행
```console
(venv) C:\> pip install jupyter
(venv) C:\> jupyter notebook
```
6. 예제 다운로드
```console
C:\> git clone https://github.com/golbin/TensorFlow-Tutorials.git
```   

[^1]: Bengio, Y.; Courville, A.; Vincent, P. (2013). "Representation Learning: A Review and New Perspectives". IEEE Transactions on Pattern Analysis and Machine Intelligence. 35 (8): 1798–1828. arXiv:1206.5538. doi:10.1109/tpami.2013.50.
[^2]: Schmidhuber, J. (2015). "Deep Learning in Neural Networks: An Overview". Neural Networks. 61: 85–117. arXiv:1404.7828. doi:10.1016/j.neunet.2014.09.003. PMID 25462637.
[^3]: Bengio, Yoshua; LeCun, Yann; Hinton, Geoffrey (2015). "Deep Learning". Nature. 521 (7553): 436–444. Bibcode:2015Natur.521..436L. doi:10.1038/nature14539. PMID 26017442.
[^4]: Ciresan, Dan; Meier, U.; Schmidhuber, J. (June 2012). "Multi-column deep neural networks for image classification". 2012 IEEE Conference on Computer Vision and Pattern Recognition: 3642–3649. arXiv:1202.2745. doi:10.1109/cvpr.2012.6248110. ISBN 978-1-4673-1228-8.
[^5]: Krizhevsky, Alex; Sutskever, Ilya; Hinton, Geoffry (2012). "ImageNet Classification with Deep Convolutional Neural Networks" (PDF). NIPS 2012: Neural Information Processing Systems, Lake Tahoe, Nevada.
[^6]: "Google's AlphaGo AI wins three-match series against the world's best Go player". TechCrunch. 25 May 2017.
[^7]: Marblestone, Adam H.; Wayne, Greg; Kording, Konrad P. (2016). "Toward an Integration of Deep Learning and Neuroscience". Frontiers in Computational Neuroscience. 10: 94. doi:10.3389/fncom.2016.00094. PMC 5021692. PMID 27683554.
[^8]: Olshausen, B. A. (1996). "Emergence of simple-cell receptive field properties by learning a sparse code for natural images". Nature. 381 (6583): 607–609. Bibcode:1996Natur.381..607O. doi:10.1038/381607a0. PMID 8637596.
[^9]: Bengio, Yoshua; Lee, Dong-Hyun; Bornschein, Jorg; Mesnard, Thomas; Lin, Zhouhan (2015-02-13). "Towards Biologically Plausible Deep Learning". arXiv:1502.04156 [cs.LG].
