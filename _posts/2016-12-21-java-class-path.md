---
layout: post
title:  java class path 
date:   2016-12-21 19:09 
categories: tech 
---

## I was try to learn java and use a simple lib

```java

import edu.princeton.cs.algs4.*;

public class first {
	   public static void main(String[] args) { 
	        StdOut.println("Hello from algs4");
	    }
}

```

## try to compile in command line

```bash
javac first.java
javac -cp ../lib/algs4.jar first.java
cd src
javac -cp ../lib/algs4.jar first.java
vim first.
vim first.java
vim ../lib/algs4.jar
vim first.java
javac -cp ../lib/algs4.jar first.java
vim first.java
javac -cp ../lib/algs4.jar first.java
vim first.java
javac -cp ../lib/algs4.jar first.java
tmux attach
tmux
ls
cd ..
cd lib
vim algs4.jar
vim first.java
javac -cp ../lib/algs4.jar first.java
java first
java -cp ../lib/algs4.jar first
java first
java first.class
ls
vim first.java
java -cp ../lib/algs4.jar first
javac -cp ../lib/algs4.jar first
javac -cp ../lib/algs4.jar first.java
ls -lah
java -cp ../lib/algs4.jar first
javac first.java
java -cp ../lib/algs4.jar first
javac -cp ../lib/algs4.jar first.class
javac -cp ../lib/algs4.jar first.java
java first
javac -cp . first.java
javac -cp ../lib/algs4.jar first.java
java first
man java
java -jar ../lib/algs4.jar first
java -jar ../lib/ first
java -jar ../lib/algs4.jar first
cd ..
cd bin
..
rmr bin
cd src
java -jar ../lib/algs4.jar first
java  first
ls
which java
java first.class
java first
java -cp ../lib/algs4.jar first
java -cp ../lib first
echo $CLASSPATH
exit
vim dotfiles/zsh/path.zsh
ls
exit
echo $CLASSPATH
cd
cd Dropbox
cd language/java/algorithm
cd src
javac first.java
java first
ls
java first
ls
vim java_classpath

```

## finally,

```bash
export CLASSPATH=$HOME/dev/all/java/lib/algs4.jar:$CLASSPATH
```
solve all the problem

```bash
javac first.java
java first
```


## sigh.

I remeber the time in college. I try to set the path for java. 
take me a whole morning to get it work. becuase I do not know that 
'./path/' vs '/path' has a great difference.


now more than 5 years later, I am still strugling with the java basic problem.

I should use an IDE, but generally I find IDE are hard to use. I get frustrated when I can not
get the simplest thing work in graphic interface. 

