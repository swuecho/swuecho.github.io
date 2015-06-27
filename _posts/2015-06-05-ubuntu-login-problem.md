---
layout: post
title: a mess after autoremove in ubuntu
date: 2015-06-05 13:19 
categories: tech 
---

accidently run autoremove,

    sudo apt-get install autoremove

suddenly, I can not login in any more.

the first thing to do is check the log when something goes wrong, but I did not do this until all the google search result fails.

some how get 

    pam_waleet.so is missing in /var/log/auth.log

after install pam_wallet package, 

    user ingroup nopasswdlogin in /var/log/auth.log

the result is: I understand why most normal people do not use linux desktop. too many bugs.

besides, one of the answer is to install xubuntu-desktop, I did that. 
later I realize it is not the solution. however, I can not uninstall the xubuntu-desktop easily.

the annoying part is the greater is not the default ubuntu unity greeter any more

    sudo apt-get remove lightdm-gtk-greeter

will remove the xubuntu greater. the bad part is I can not find the above command line by googling easily.

I end up reinstalling my laptop.

However, the install is not very smooth either.

I create the usb installer following the ubuntu offical doc. I know I have to change the boot order. make USB HDD comes first.

Somehow, when I install, the install lead me to busybox. totally lost.

Accidently, I unplug the usb and put it into another usp port. suddenly, the install interface appears. HaHa!

so the lesson is you have to be careful about which usb port to either too.

this end my several days fighting with ubuntu login loop.




