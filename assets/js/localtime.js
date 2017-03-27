new Vue({
  el: '#app',
  data: {
     message: '3/30/2017 12:00 PM UTC'
  },
  methods: {
    transform: function () {
      var date_string= this.message;
      var date = new Date(date_string);
      return date.toString()
    }
  }
})
