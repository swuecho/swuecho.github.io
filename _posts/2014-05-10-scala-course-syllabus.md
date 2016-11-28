---
layout: post
title:  "Scala Course Syllabus"
date:   2014-05-10 15:52:00
categories: tech 
---
I think for every programming language, you should think about this concepts

<ul>
<li> 1.1 - Programming Paradigms </li>
<li> 1.2 - Elements of Programming </li>
<li> 1.3 - Evaluation Strategies and Termination </li>
<li> 1.4 - Conditionals and Value Definitions </li>
<li> 1.5 - Example square roots with Newtons method </li>
<li> 1.6 - Blocks and Lexical Scope </li>
<li> 2.1 - Tail Recursion </li>
<li> 2.2 - Higher-Order Functions </li>
<li> 2.3 - Currying </li>
<li> 2.4 - Example Finding Fixed Points </li>
<li> 2.5 - Scala Syntax Summary </li>
<li> 3.1 - Functions and Data </li>
<li> 3.2 - More Fun With Rationals </li>
<li> 3.3 - Evaluation and Operators </li>
<li> 3.4 - Class Hierarchies </li>
<li> 3.5 - How Classes Are Organized </li>
<li> 5.1 - Lists </li>
<li> 5.2 - More Functions on Lists </li>
<li> 5.3 - Pairs and Tuples </li>
<li> 5.4 - Implicit Parameters </li>
<li> 5.5 - Higher-Order List Functions </li>
<li> 5.6 - Reduction of Lists </li>
<li> 5.7 - Reasoning About Concat </li>
<li> 5.8 - A Larger Equational Proof on Lists </li>
<li> 4.1 - Polymorphism </li>
<li> 4.2 - Objects Everywhere </li>
<li> 4.3 - Functions as Objects </li>
<li> 4.4 - Subtyping and Generics </li>
<li> 4.5 - Variance </li>
<li> 4.6 - Decomposition </li>
<li> 4.7 - Pattern Matching </li>
<li> 6.1 - Other Collections </li>
<li> 6.2 - Combinatorial Search and For-Expressions </li>
<li> 6.3 - Combinatorial Search Example </li>
<li> 6.4 - Queries with For </li>
<li> 6.5 - Translation of For </li>
<li> 6.6 - Maps </li>
<li> 6.7 - Putting the Pieces Together </li>
<li> 7.1 - Structural Induction on Trees </li>
<li> 7.2 - Streams </li>
<li> 7.3 - Lazy Evaluation </li>
<li> 7.4 - Computing with Infinite Sequences </li>
<li> 7.5 - Case Study the Water Pouring Problem </li>
<li> 7.6 - Course Conclusion </li>
</ul>

this following two pictures show how I get the syllabus above.

![](/assets/img/scala_course_syllabus_01.png)

then perl onliner.


```ruby
 ls | perl -aF/Lecture/ -e 'print $F[1]' | perl -n -E 'chomp;s/\(.*//;say "<li>$_</li>"'

 ls | perl -aF/Lecture/ -E 'say "<li>" . $F[1]=~s/\(.*//rsg . "</li>"'
```

![](/assets/img/scala_course_syllabus_02.png)
