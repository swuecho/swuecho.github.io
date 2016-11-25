new Vue({
  el: '#app',
  data: {
    message: '123'
  },
  methods: {
    transform: function () {
      var number = this.message;
      var whole = number.split('.')[0]
      var part = number.split('.')[1]
      if (part) {
        return writtenNumber(whole) + ' and ' + writtenNumber(part);
      } else {
        return writtenNumber(whole);
      }
    }
  }
})
