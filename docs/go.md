---
description: >
  This chapter shows how to upgrade Hydejack to a newer version. The method depends on how you've installed Hydejack.
hide_description: true
---

# Go
Go (often referred to as Golang) is a statically typed, compiled programming language designed at Google[^1] by Robert Griesemer, Rob Pike, and Ken Thompson.[^2] Go is syntactically similar to C, but with the added benefits of memory safety, garbage collection, structural typing,[^3] and CSP-style concurrency.[^4]

There are two major implementations:
* Google's self-hosting[^5] compiler toolchain targeting multiple operating systems, mobile devices,[^6] and WebAssembly.[^7]
* gccgo, a GCC frontend.[^8][^9]

A third compiler, GopherJS,[^10] compiles Go to JavaScript for front-end web development.

{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}
![Screenshot](/assets/img/docs/golang.png)

## Getting Started
### Download the Go distribution

[**Download Go**](https://golang.org/dl/)  

Official binary distributions are available for the FreeBSD (release 10-STABLE and above), Linux, macOS (10.10 and above), and Windows operating systems and the 32-bit (386) and 64-bit (amd64) x86 processor architectures.

If a binary distribution is not available for your combination of operating system and architecture, try [installing from source](https://golang.org/doc/install/source) or [installing gccgo instead of gc](https://golang.org/doc/install/gccgo).
#### System requirements
[Go binary distributions](https://golang.org/dl/) are available for these supported operating systems and architectures. Please ensure your system meets these requirements before proceeding. If your OS or architecture is not on the list, you may be able to install from source or use gccgo instead.

|Operating system|Architectures|Notes|
|---|---|---|
|FreeBSD 10.3 or later|amd64, 386|Debian GNU/kFreeBSD not supported|
|Linux 2.6.23 or later with glibc|amd64, 386, arm, arm64, s390x, ppc64le|CentOS/RHEL 5.x not supported. Install from source for other libc.|
|macOS 10.10 or later|amd64|use the clang or gcc† that comes with Xcode‡ for cgo support|
|Windows 7, Server 2008R2 or later|amd64, 386|use MinGW gcc†. No need for cygwin or msys.|

* †A C compiler is required only if you plan to use cgo.  
* ‡You only need to install the command line tools for Xcode. If you have already installed Xcode 4.3+, you can install it from the Components tab of the Downloads preferences panel.

### Install the Go tools
If you are upgrading from an older version of Go you must first remove the existing version.
#### Linux, macOS, and FreeBSD tarballs
Download the archive and extract it into `/usr/local`, creating a Go tree in `/usr/local/go`.  
For example:
```bash
tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz
```
Choose the archive file appropriate for your installation.  
For instance, if you are installing Go version 1.2.1 for 64-bit x86 on Linux,  
the archive you want is called `go1.2.1.linux-amd64.tar.gz`.
(Typically these commands must be run as root or through sudo.)

Add `/usr/local/go/bin` to the PATH environment variable.  
You can do this by adding this line to your `/etc/profile` (for a system-wide installation) or `$HOME/.profile`:
```bash
export PATH=$PATH:/usr/local/go/bin
```
Note: changes made to a profile file may not apply until the next time you log into your computer.  
To apply the changes immediately, just run the shell commands directly  
or execute them from the profile using a command such as source `$HOME/.profile`.
{:.message}
#### macOS package installer
Download the package file, open it, and follow the prompts to install the Go tools.  
The package installs the Go distribution to `/usr/local/go`.
The package should put the `/usr/local/go/bin directory` in your PATH environment variable.  
You may need to restart any open Terminal sessions for the change to take effect.
#### Windows
The Go project provides two installation options for Windows users (besides installing from source):   
a **zip archive** that requires you to set some environment variables and an **MSI installer** that configures your installation automatically.
##### MSI installer
Open the MSI file and follow the prompts to install the Go tools.  
By default, the installer puts the Go distribution in `c:\Go`.
The installer should put the `c:\Go\bin` directory in your **PATH** environment variable.  
You may need to restart any open command prompts for the change to take effect.
##### Zip archive
Download the zip file and extract it into the directory of your choice (we suggest c:\Go).  
If you chose a directory other than `c:\Go`, you must set the GOROOT environment variable to your chosen path.  
Add the bin subdirectory of your Go root (for example, c:\Go\bin) to your **PATH** environment variable.
##### Setting environment variables under Windows
Under Windows, you may set environment variables   
through the "Environment Variables" button on the __"Advanced"__ tab of the __"System"__ control panel.  
Some versions of Windows provide this control panel  
through the "Advanced System Settings" option inside the "System" control panel.

### Test your installation
Check that Go is installed correctly by setting up a workspace and building a simple program, as follows.

Create your workspace directory, `%USERPROFILE%\go`.  
(If you'd like to use a different directory, you will need to set the **GOPATH** environment variable.)

Next, make the directory src/hello inside your workspace,  
and in that directory create a file named hello.go that looks like:
```go
package main

import "fmt"

func main() {
	fmt.Printf("hello, world\n")
}
```
Then build it with the go tool:
```console
C:\> cd %USERPROFILE%\go\src\hello
C:\Users\Gopher\go\src\hello> go build
```
The command above will build an executable named hello.exe in the directory alongside your source code.  
Execute it to see the greeting:

```console
C:\Users\Gopher\go\src\hello> hello
hello, world
```
If you see the "hello, world" message then your Go installation is working.  
You can run go install to install the binary into your workspace's bin directory or go clean -i to remove it.

Before rushing off to write Go code please read the [How to Write Go Code](https://golang.org/doc/code.html) document,  
which describes some essential concepts about using the Go tools.

### Uninstalling Go
To remove an existing Go installation from your system delete the go directory.  
This is usually `/usr/local/go` under Linux, macOS, and FreeBSD or `c:\Go` under Windows.

You should also remove the Go bin directory from your PATH environment variable.  
Under Linux and FreeBSD you should edit `/etc/profile` or `$HOME/.profile`.  
If you installed Go with the macOS package then you should remove the `/etc/paths.d/go` file.   
Windows users should read the section about setting environment variables under Windows.

### Getting help
For help, see the [list of Go mailing lists, forums, and places to chat](https://golang.org/help/).  
Report bugs either by running **"go bug"**, or manually at the [Go issue tracker](https://golang.org/issue).


[^1]: Kincaid, Jason (November 10, 2009). "Google's Go: A New Programming Language That's Python Meets C++". TechCrunch. Retrieved January 18, 2010.
[^2]: "Language Design FAQ". golang.org. January 16, 2010. Retrieved February 27, 2010.
[^3]: "Why doesn't Go have "implements" declarations?". golang.org. Retrieved October 1, 2015.
[^4]: Metz, Cade (May 5, 2011). "Google Go boldly goes where no code has gone before". The Register.
[^5]: "Go 1.5 Release Notes". Retrieved January 28, 2016. "The compiler and runtime are now implemented in Go and assembler, without C."
[^6]: "Google's In-House Programming Language Now Runs on Phones". wired.com. August 19, 2015.
[^7]: "Go 11.1 is Released - The Go Blog". August 24, 2018. Retrieved January 1, 2019.
[^8]: "FAQ: Implementation". golang.org. January 16, 2010. Retrieved January 18, 2010.
[^9]: "Installing GCC: Configuration". Retrieved December 3, 2011. Ada, Go and Objective-C++ are not default languages
[^10]: https://github.com/gopherjs/gopherjs