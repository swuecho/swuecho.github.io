---
layout: post
title:  extact html table contents in chrome dev console 
date:   2022-03-19 11:16 
categories: tech
---
<p>
</p>
<p>
</p>
<p>
  <strong>如何在chrome dev console 用代码提取表格数据</strong>
</p>
<pre>
<code>table_2020 = $('#app > div.container-lg.clearfix.red-rise-green-fall > div.container-md.float-left.stockinfomain > div > table:nth-child(4) > tbody')
trs = table_2020.children()
k.fn.init(10) [tr, tr, tr, tr, tr, tr, tr, tr, tr, tr, prevObject: k.fn.init(1)]
trs[2].children[2].innerText
"6.17%"
// third column
// why have to use Array.from
Array.from(trs).map(x => x.childNodes[2].innerText)
Array.from(trs).map(x => x.childNodes[2].innerText.replace('%', '')).map(x => parseFloat(x)).reduce( (x,y) => x + y)</code>
</pre>
<p>
</p>
