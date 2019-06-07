<template>
  <div>
    <template v-if="!group">
      <Form
        :formId="formId"
        :feilds="formFeilds"
      />
      <button @click="commit">
        Create
      </button>
    </template>
    <template v-else>
      <p>You created a new group!</p>
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
      formId: 'create-group-form',
      formFeilds: [
        {
          name: 'Group Name',
          type: 'text',
          placeholder: 'Group name.',
          value: '',
        },
        {
          name: 'Description',
          type: 'text',
          placeholder: 'Tell some thing aboud this group.',
          value: '',
        },
        {
          name: 'Join Code',
          type: 'text',
          placeholder: 'Password for this group.',
          value: '',
        },
      ],
      group: null,
    }
  },
  methods: {
    commit() {
      var form = new FormData(document.getElementById(this.formId))
      API.post('/groups', (resp) => {
        this.group = resp.group
        this.$emit('update')
      }, form)
    }
  }
}
</script>
