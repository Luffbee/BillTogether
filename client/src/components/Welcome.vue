<template>
  <div id="welcome">
    Welcome<br>
    <button @click="gologin">Login</button>
    <button @click="goregister">Register</button>
  </div>
</template>

<script>
import { store } from './common/Store.vue'

export default {
  methods: {
    gologin() {
      store.goLogin()
    },
    goregister() {
      store.goRegister()
    },
  }
}
</script>
