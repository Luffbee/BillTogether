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
import Form from '../common/Form.vue'
import { store } from '../common/Store.vue'
import API from '../common/API.vue'

export default {
  components: {
    Form,
  },
  data() {
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
      var form = new FormData(document.getElementById(this.formId))
      API.post('/login', (resp) => {
        store.loginSuccess(resp)
      }, form)
    }
  }
}
</script>
