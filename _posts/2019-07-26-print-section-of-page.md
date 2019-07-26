---
layout: post
title:  print section of page 
date:   2019-07-26 09:57 
categories: tech 
---


<div class="doc-note">
1. in chrome, navigation to the page you want to print, 
</div>

in the console, execute this function:

```js
function print_section(section_id) {

    var newWindow = window.open();
    newWindow.document.write(document.getElementById(section_id).innerHTML);
    newWindow.print();
}

```

<div class="doc-note">
2. find the section id you want to print:
</div>

```
print_section("sql-expression-language-tutorial")
```

if there is no id in the section you want to print, simply add a id to the element by opening the elements tab in chrome 
console.

the pdf is not perfect as latexpdf, but acceptable.



credit: https://stackoverflow.com/questions/1071962

