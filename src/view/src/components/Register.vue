<template>
  <div id="register">
    Register
    <Form
      :formId="formId"
      :feilds="formFeilds"
    />
    <button @click="commit">
      Register
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
      formId: 'register-form',
      formFeilds: [
        {
          name: 'Email',
          type: 'email',
          placeholder: 'Email',
          value: '',
        },
        {
          name: 'Name',
          type: 'text',
          placeholder: 'Username',
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
    commit() {
      this.errmsg = ""
      var form = new FormData(document.getElementById(this.formId))
      var xhr = new XMLHttpRequest()
      var vm = this
      xhr.onload = function() {
        if (this.status == 200) {
          vm.$emit('register-success', this.response)
        } else {
          vm.$emit('api-error', this.response.error)
        }
      }
      xhr.open('POST', '/api/v1/register')
      xhr.responseType = 'json'
      xhr.send(form)
    }
  }
}
</script>
