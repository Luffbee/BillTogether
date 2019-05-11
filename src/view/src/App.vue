<template>
  <div id="app">
    <component
      :is="currentPage"
      v-bind="props"
      @go-login="goLogin"
      @go-register="goRegister"
      @login-success="loginSuccess"
      @register-success="loginSuccess"
      @logout-success="logoutSuccess"
      @api-error="apiError"
    ></component>
    <div id="error" v-if="error">
      {{ error.message }}
    </div>
  </div>
</template>

<script>
//import HelloWorld from './components/HelloWorld.vue'
import Welcome from './components/Welcome.vue'
import Login from './components/Login.vue'
import Register from './components/Register.vue'
import Home from './components/Home.vue'

export default {
  name: 'app',
  components: {
    Login,
  },
  data () {
    return {
      currentPage: Welcome,
      user: null,
      props: {},
      error: null,
    }
  },
  methods: {
    apiError (err) {
      this.error = err
    },
    goHome () {
      this.error = null
      this.props = {
        user: this.user
      }
      this.currentPage = Home
    },
    goLogin () {
      this.error = null
      if (this.user) {
        this.goHome()
        return
      }
      var xhr = new XMLHttpRequest()
      var vm = this
      xhr.onload = function() {
        if (this.status == 200) {
          vm.user = this.response.user
          vm.goHome()
        } else {
          vm.currentPage = Login
        }
      }
      xhr.open('GET', '/api/v1/user')
      xhr.responseType = 'json'
      xhr.send()
    },
    goRegister () {
      this.error = null
      this.user = null
      this.props = {}
      this.currentPage = Register
    },
    loginSuccess (rep) {
      this.error = null
      this.user = rep.user
      this.goHome()
    },
    logoutSuccess () {
      this.error = null
      this.user = null
      this.props = {}
      this.currentPage = Welcome
    }
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
