<template>
  <div id="home">
    Current user:
    <p><em>Id:</em> {{ user.id }}</p>
    <p><em>Name:</em> {{ user.name }}</p>
    <p><em>Email:</em> {{ user.email }}</p>
    <button @click="logout">Logout</button>
  </div>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      required: true,
    },
  },
  methods: {
    logout () {
      var xhr = new XMLHttpRequest()
      var vm = this
      xhr.onload = function() {
        if (this.status == 200) {
          vm.$emit('logout-success')
        } else {
          vm.$emit('api-error', this.response.error)
        }
      }
      xhr.open('POST', '/api/v1/logout')
      xhr.responseType = 'json'
      xhr.send()
    }
  }
}
</script>
