<script>
import Welcome from './Welcome.vue'
import Login from './Login.vue'
import Register from './Register.vue'
import Home from './Home.vue'
export let store = {
  state: {
    currentView: Welcome,
    user: null,
    error: null,
  },
  apiError(err) {
    this.state.error = err
  },
  goHome() {
    this.state.error = null
    this.state.currentView = Home
  },
  goLogin() {
    this.state.error = null
    if (this.user) {
      this.goHome()
      return
    }
    var xhr = new XMLHttpRequest()
    var st = this
    xhr.onload = function() {
      if (this.status == 200) {
        st.state.user = this.response.user
        st.goHome()
      } else {
        st.state.currentView = Login
      }
    }
    xhr.open('GET', '/api/v1/user')
    xhr.responseType = 'json'
    xhr.send()
  },
  goRegister() {
    this.state.error = null
    this.state.user = null
    this.state.currentView = Register
  },
  loginSuccess(rep) {
    this.state.error = null
    this.state.user = rep.user
    this.goHome()
  },
  logoutSuccess() {
    this.state.error = null
    this.state.user = null
    this.state.currentView = Welcome
  }
}
</script>
