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
      var vm = this
      xhr.onload = function() {
        if (this.status == 200) {
          vm.$emit('login-success', this.response)
        } else {
          vm.$emit('api-error', this.response.error)
        }
      }
      xhr.open('POST', '/api/v1/login')
      xhr.responseType = 'json'
      xhr.send(form)
    }
  }
}
</script>
