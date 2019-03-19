---
layout: post
title: 'Jupyter notebook installation' 
author: haeyeon.hwang
tags: [jupyter]
description: >
  Project Jupyter (/ˈdʒuːpɪtər/ (About this soundlisten)) is a nonprofit organization created to "develop open-source software, open-standards, and services for interactive computing across dozens of programming languages". 
image: /assets/img/blog/node.js.png
hide_image: true
---
{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}

## [**Jupyter notebook installation**](https://jupyter.org/install)
1. Prerequisite: Python
2. Installation
    * using [anaconda](https://www.anaconda.com/downloads)
    * using pip

    ~~~bash
    > pip install -U pip virtualenv
    > virtualenv --system-site-packages -p python ./venv
    (venv) > .\venv\Scripts\activate
    (venv) > pip -m pip install --upgrade pip
    (venv) > pip list
    (venv) > pip install jupyter
    (venv) > jupyter notebook
    ...
    (venv) > deactivate
    ~~~

3. [Running the notebook](https://jupyter.readthedocs.io/en/latest/running.html#running)

## **Jupyter notebook in cloud
* [MS Azure](https://notebooks.azure.com/)
* [Google Colaboratory](https://colab.research.google.com/)
* [Paize](https://paiza.cloud/en/)
* [Cocalc](https://cocalc.com/)

## **References**
* [Jupyter Documentation](https://jupyter.readthedocs.io/en/latest/install.html)
* [Jupyter/IPython notebook quick start guide](https://jupyter-notebook-beginner-guide.readthedocs.io/en/latest/index.html)
* [Top 5 : Online Notebook (ipynb) and other cloud services](https://medium.com/@siddesh.001/top-5-online-free-notebook-ipynb-and-other-cloud-services-dbf9580d99e3)
