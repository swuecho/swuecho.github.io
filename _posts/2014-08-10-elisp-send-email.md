---
layout: post
title:  Send Email using elisp script  
date:   2014-08-10 17:00 
categories: tech 
---

Send Email using elisp script  

```{elisp}

#!/usr/bin/emacs --script

(setq send-mail-function 'smtpmail-send-it)
(setq smtpmail-smtp-server "smtp.gmail.com")

(progn
    (mail)
    (mail-to) (insert "echowuhao@gmail.com")
    (mail-subject) (insert "the subject")
    (mail-text) (insert "body of mail")
    (mail-send))

```

