---
layout: post
title:  YouCompleteMe? You Joke me
 
date:   2015-12-21 11:14 
categories: tech 
---
try to install, YouCompleteMe.

after I config vimrc. I open it, it tell me vim is tooooo old. (3 years is too old for software)

then I install vim. fortunately, I find a ppa, so I do not have to manual install it.

however, I have to complie YCM, but cmake is too old too.

then I have to install cmake, because the default version in 12.04 does not work any more. 

then open vim, try to edit a file. do not work as expected.

the err msg  indicate YCM server shutdown,

then googling, find a bug report about this and I know I have to
enable log to see what is wrong.

    let g:ycm_server_keep_logfiles = 1   
    let g:ycm_server_log_level = 'debug'


<code>:YcmDebugInfo</code> I find where to find the problem,

I see

{% highlight bash %}
ImportError: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version `GLIBCXX_3.4.18' not found (required by /home/hwu/dotfiles/vim/.vim/bundle/YouCompleteMe/third_party/ycmd/ycmd/../lib    clang.so.3.7)
{% endhighlight %}

in /tmp/ycm_temp/xxxx_stderr.log

then check the full install guide, I know, I have to install newer libclang. I have to give up and rerun
<code> ./install.py </code> instead


2 hour passed!!! What is the fuck!!!! You Joke Me!



Update: When I was reintall it, it will not compile. In the end I found the problem was not enought memory in my vm. 
create an swap partition solved the problem.

