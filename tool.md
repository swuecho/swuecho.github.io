---
layout: page
title: Tool
permalink: /tool/
---

### Arabic Number to Written Number translator

<script src="/assets/js/vue.js"></script>
<script src="/assets/js/number_transform.js"></script>
<title>Widgets</title>
<body>
<div id="app">
<p> please input a number, such as 1234</p>
<input v-model="message">
<p>{{ message }}</p>
<p>{{ transform(message) }}</p>
</div>
<p>
<script>
new Vue({
  el: '#app',
  data: {
    message: '123'
  },
  methods: {
    transform: function () {
      return writtenNumber(this.message)
    }
  }
})
</script>

