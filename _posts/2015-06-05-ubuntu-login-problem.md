---
layout: post
title: a mess after autoremove in ubuntu
date: 2015-06-05 13:19 
categories: tech 
---

   sudo apt-get install autoremove

accidently run autoremove, then
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


I end up reinstall my laptop.




