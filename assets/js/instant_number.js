new Vue({
  el: '#app',
  data: {
    message: '123'
  },
  methods: {
    transform: function () {
      number = this.message;
      let (whole,part) = number.split('.') 
      if (part) {
        return writtenNumber(whole) + ' and ' + writtenNumber(part);
      } else {
        return writtenNumber(whole);
      }
    }
  }
})
