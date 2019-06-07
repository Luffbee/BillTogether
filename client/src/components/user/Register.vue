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
import Form from '../common/Form.vue'
import { store } from '../common/Store.vue'
import API from '../common/API.vue'

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
      var form = new FormData(document.getElementById(this.formId))
      API.post('/register', (resp) => {
        store.loginSuccess(resp)
      }, form)
    }
  }
}
</script>
