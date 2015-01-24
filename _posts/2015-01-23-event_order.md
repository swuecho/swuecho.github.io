---
layout: post
title:  [ExtJS] the event order
date:   2015-01-23 21:08 
categories: tech 
---
Below is the script to get the event order of Ext.Component

{% highlight javascript %}

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
 
{% endhighlight %}



<iframe> src="https://fiddle.sencha.com/fiddle/h28"></iframe>

## todo

1. add all event.
2. how event works


