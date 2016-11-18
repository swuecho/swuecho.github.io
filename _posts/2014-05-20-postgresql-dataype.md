---
layout: post
title:  "postgresql data type"
date:   2014-05-20 15:52:00
categories: tech 
---

postgresql datatype

<div>
<table>
<caption><strong>table:</strong>common data types in postgresql</caption>
<tr><td align="left">character string</td>
<td align="left"><small>char</small>(length)<a name="1567">&#160;</a></td>
<td align="left">blank-padded string, fixed storage length</td>
</tr>
<tr><td align="left">&nbsp;</td>
<td align="left"><small>varchar</small>(length)<a name="1569">&#160;</a></td>
<td align="left">variable storage length</td>
</tr>
<tr><td align="left">number</td>
<td align="left"><small>integer</small><a name="1571">&#160;</a></td>
<td align="left">integer, +/-2 billion range</td>
</tr>
<tr><td align="left">&nbsp;</td>
<td align="left"><small>float</small><a name="1573">&#160;</a></td>
<td align="left">floating point number, 15-digit precision</td>
</tr>
<tr><td align="left">&nbsp;</td>
<td align="left"><small>numeric</small><a name="1575">&#160;</a>(precision, decimal)</td>
<td align="left">number with user-defined precision and decimal</td>
</tr>
<tr><td align="left">&nbsp;</td>
<td align="left">&nbsp;</td>
<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;location</td>
</tr>
<tr><td align="left">date/time</td>
<td align="left"><small>date</small><a name="1577">&#160;</a></td>
<td align="left">date</td>
</tr>
<tr><td align="left">&nbsp;</td>
<td align="left"><small>time</small><a name="1579">&#160;</a></td>
<td align="left">time</td>
</tr>
<tr><td align="left">&nbsp;</td>
<td align="left"><small>timestamp</small><a name="1581">&#160;</a></td>
<td align="left">date and time</td>
</tr>
</table>
</div>

if put this in the table header, it will be escpased by jekyll. very strange 

```{html}
<tr>
<td align="center" colspan=1>category</td>
<td align="center" colspan=1>type</td>
<td align="center" colspan=1>description</td>
</tr>
```
