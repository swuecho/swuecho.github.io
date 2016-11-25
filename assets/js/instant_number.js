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
