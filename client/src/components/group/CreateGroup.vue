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
      var data = API.form2obj(this.formId)
      API.post('/groups', (resp) => {
        this.group = resp.group
        this.$emit('update')
      }, data)
    }
  }
}
</script>
