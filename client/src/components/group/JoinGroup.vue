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
      <GroupInfo
        v-bind="group"
      ></GroupInfo>
    </template>
    <button @click="$emit('close')">
      Close
    </button>
  </div>
</template>

<script>
import Form from '../common/Form.vue'
import GroupInfo from './GroupInfo.vue'
import API from '../common/API.vue'

export default {
  components: {
    Form,
    GroupInfo,
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
      var form = new FormData(document.getElementById(this.formId))
      var gid = form.get('group-id').toString()
      API.post('/groups/' + gid, (resp) => {
        this.group = resp.group
        this.$emit('update')
      }, form)
    }
  }
}
</script>
