---
layout: post
title:  abstract is not always good
date:   2015-06-08 20:15 
categories: tech 
---

## 吐槽： 抽象真是不一定好


我有个同事, 每次review的时候, 就想办法优化，压缩我的代码。
代码应该反映最初的思路，在代码基础上优化，结果就是尼玛根本不知道最初的本意了。
就是为了省两行代码。 

有时候，他还提供代码，有意思的是，超过三行以上的，对的可能性不大。

有一次，我已经commit了，他还勤快，自己改了之后，再commit，结果test 跑不过了，又改回来。精神倒是可嘉，不过真是浪费自己和他人的时间。


还有个同事，特别喜欢抽象。

哪怕写三个class，人家非得找个共同点，然后写个 XXabstact class。有时候，这些 class 并不能很自然的提取出来一个XXabstract class， 那就在 abstract class 里，用if else 解决。 结果是，最终的class 是短了，不过，尼玛你要看 最终的class ，根本不知道是干啥的。因为主要的逻辑转移到了那个XXabstract class。 这样下来，就是让所有的class 同样复杂。 因为你读任意一个最终的class，都要把那个屎一样的abstractXX class 读一遍。


