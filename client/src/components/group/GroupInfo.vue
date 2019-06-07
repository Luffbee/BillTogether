<template>
  <div>
    <div><em>{{ name }}</em></div>
    <div v-if="detail" class="group-details">
      <p><em>Id:</em> {{ id }}</p>
      <p><em>Create Time:</em> {{ new Date(create_time).toLocaleString() }}</p>
      <p><em>Join Code:</em> {{ joincode }}</p>
      <p>{{ desc }}</p>
      <p>
        <em>Users:</em>
        <ul>
          <li v-for="user in users" :key="user.id">
            <UserInfo
              v-bind="user"
            ></UserInfo>
          </li>
        </ul>
      </p>
    </div>
  </div>
</template>

<script>
import UserInfo from '../user/UserInfo.vue'

export default {
  props: {
    detail: Boolean,
    id: Number,
    name: String,
    desc: String,
    create_time: String,
    users: Array,
    joincode: String,
  },
  components: {
    UserInfo,
  },
  data() {
    return {
    }
  },
  methods: {
  }
}
</script>
