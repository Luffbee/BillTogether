<template>
  <div>
    <template v-if="!group">
      <Form
        :formId="formId"
        :feilds="formFeilds"
      />
      <button @click="commit">
        Join
      </button>
    </template>
    <template v-else>
      <p>You are now in this group:</p>
      <GroupDetail
        v-bind="group"
      ></GroupDetail>
    </template>
    <button @click="$emit('close')">
      Close
    </button>
  </div>
</template>

<script>
import Form from '../common/Form.vue'
import GroupDetail from './GroupDetail.vue'
import API from '../common/API.vue'

export default {
  components: {
    Form,
    GroupDetail,
  },
  data() {
    return {
      formId: 'join-group-form',
      formFeilds: [
        {
          name: 'Group Id',
          type: 'number',
          placeholder: 'Group Id',
          value: '',
        },
        {
          name: 'Join Code',
          type: 'text',
          placeholder: 'Join Code',
          value: '',
        },
      ],
      group: null,
    }
  },
  methods: {
    commit() {
      var data = API.form2obj(this.formId)
      var gid = data['group-id'].toString()
      API.post('/groups/' + gid, (resp) => {
        this.group = resp.group
        this.$emit('update')
      }, data)
    }
  }
}
</script>
