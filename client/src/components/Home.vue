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
import { store } from './Store.vue'

export default {
  data() {
    return {
      user: store.state.user,
    }
  },
  methods: {
    logout() {
      var xhr = new XMLHttpRequest()
      xhr.onload = function() {
        if (this.status == 200) {
          store.logoutSuccess()
        } else {
          store.apiError(this.response.error)
        }
      }
      xhr.open('POST', '/api/v1/logout')
      xhr.responseType = 'json'
      xhr.send()
    }
  }
}
</script>
