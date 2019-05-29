<template>
  <div id="login">
    Login
    <Form
      :formId="formId"
      :feilds="formFeilds"
    />
    <button @click="commit">
      Login
    </button>
  </div>
</template>

<script>
import Form from './Form.vue'
import { store } from './Store.vue'

export default {
  components: {
    Form,
  },
  data () {
    return {
      formId: 'login-form',
      formFeilds: [
        {
          name: 'Email',
          type: 'text',
          placeholder: 'Email',
          value: '',
        },
        {
          name: 'Password',
          type: 'password',
          placeholder: 'Password',
          value: '',
        },
      ],
    }
  },
  methods: {
    commit () {
      this.errmsg = ""
      var form = new FormData(document.getElementById(this.formId))
      var xhr = new XMLHttpRequest()
      xhr.onload = function() {
        if (this.status == 200) {
          store.loginSuccess(this.response)
        } else {
          store.apiError(this.response.error)
        }
      }
      xhr.open('POST', '/api/v1/login')
      xhr.responseType = 'json'
      xhr.send(form)
    }
  }
}
</script>
