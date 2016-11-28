---
layout: post
title:  ExtJS, the event order
date:   2015-01-23 21:08 
categories: tech 
---

Below is the script to get the event order of Ext.Component

```javascript

var comp = Ext.create('Ext.Component', {
    html: 'Component',
        renderTo: Ext.getBody(),
	    listeners: {
	               beforerender: function() {
		                   console.log('beforerender');
				       },
				   afterrender: function() {
					    console.log('afterrender');
					},
					active: function() {
						console.log('active');
				},
					focus: function() {
						console.log('focus');
				}
    }
});
 
```


https://fiddle.sencha.com/fiddle/h28


## rant

After writing ExtJs code for about 3 years, I still do not like it.

The worest thing about Sencha is they are agaist developers. 

Hope they will dies soon, so I do not have to deal with their code or their way of writing spa.




