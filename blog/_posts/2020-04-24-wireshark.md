---
layout: post
title: 'wireshark' 
author: haeyeon.hwang
tags: [wireshark]
image: /assets/img/blog/hackathon.png
hide_image: true
---

{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}


http://luarocks.github.io/luarocks/releases/

https://sourceforge.net/projects/mingw/

https://www.gnupg.org/download/index.html#libgcrypt
https://gpg4win.org/get-gpg4win.html


http://www.lua.org/versions.html

http://luadist.org/
https://github.com/hellohq-io/lua-openssl-example

luadist install luacrypto

-----

https://www.gnupg.org/download/index.html
download libgpg-error tarball
sh autogen.sh --build-w32
make

#define EOPNOTSUPP 45
at the top of w32-estream.c.

download libgcrypt
sh autogen.sh --build-w32
make

wget https://anonsvn.wireshark.org/wireshark-win32-libs/tags/2018-08-04/packages/libgcrypt-1.8.3-win32ws.zip
mingw32-gcc -shared -o luagcrypt.dll luagcrypt.o -Lc:/mingw/bin -llibgcrypt-20 C:/lua/lib/lua/5.3/lua53.dll -lMSVCRT
mingw32-gcc -shared -o luagcrypt.dll luagcrypt.o -Lc:/mingw/bin -llibgcrypt-20 C:/lua/lib/lua/5.3/lua53.dll -lMSVCRT
https://github.com/Lekensteyn/luagcrypt

~~~bash
$ wget https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.36.tar.bz2
$ bunzip2 libgpg-error-1.36.tar.bz2
$ tar xvf libgpg-error-1.36.tar
$ cd libgpg-error-1.36
$ sh autogen.sh --build-w64
$ make
$ make install

$ wget https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.8.4.tar.bz2
$ bunzip2 libgcrypt-1.8.4.tar.bz2
$ tar xvf libgcrypt-1.8.4.tar
$ cd libgcrypt-1.8.4
$ sh autogen.sh --build-w64
$ make 
$ make install

$ apt install lua5.3
$ apt install luarocks
$ git clone https://github.com/Lekensteyn/luagcrypt.git

> wget https://luarocks.github.io/luarocks/releases/luarocks-3.0.4-win32.zip
> unzip luarocks-3.0.4-win32.zip
> cd luarocks-3.0.4-win32
> INSTALL /P c:\LuaRocks /TREE c:\LuaRocks /CONFIG c:\LuaRocks

~~~

https://www.dllme.com/getfile.php?file=24546&id=ddd895815e8a029e423ab6a2c07a0e6d

SED = /c/cygwin64/bin/sed




apt-cache search mingw-
sudo apt-get install gcc-mingw-w64




