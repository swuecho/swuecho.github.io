---
layout: post
title:  String operation in R 
date:   2016-05-07 19:21 
categories: tech 
---
<h1>String operation in R</h1>

<p>example draw from &ldquo;The art of R programming&rdquo;</p>

<h4>grep</h4>

<pre><code class="r">grep(&quot;Pole&quot;, c(&quot;Equator&quot;, &quot;North Pole&quot;, &quot;South Pole&quot;, &quot;Sea&quot;))
</code></pre>

<pre><code>## [1] 2 3
</code></pre>

<h3>nchar</h3>

<pre><code class="r">nchar(&quot;South Pole&quot;)
</code></pre>

<pre><code>## [1] 10
</code></pre>

<h3>paste and paste0</h3>

<pre><code class="r">paste(&quot;north&quot;, &quot;Pole&quot;)
</code></pre>

<pre><code>## [1] &quot;north Pole&quot;
</code></pre>

<pre><code class="r">paste0(&quot;north&quot;, &quot;Pole&quot;, sep = &quot; &quot;)
</code></pre>

<pre><code>## [1] &quot;northPole &quot;
</code></pre>

<pre><code class="r">paste0(&quot;north&quot;, &quot;Pole&quot;)
</code></pre>

<pre><code>## [1] &quot;northPole&quot;
</code></pre>

<h2>more</h2>

<p>sprintf, substr, strsplit, regexr, regexr</p>

<h3>related package</h3>

<p>stringr</p>

<blockquote>
<p>stringr is a set of simple wrappers that make R&#39;s string
functions more consistent, simpler and easier to use.  It does
this by ensuring that: function and argument names (and
positions) are consistent, all functions deal with NA&#39;s and
zero length character appropriately, and the output data
structures from each function matches the input data structures
of other functions.</p>
</blockquote>




