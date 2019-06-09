<template>
  <div>
    <div><em>{{ name }}</em> ({{ size }})</div>
    <p><em>GId:</em> {{ id }}</p>
    <p><em>Create Time:</em> {{ new Date(create_time).toLocaleString() }}</p>
    <p><em>Join Code:</em> {{ joincode }}</p>
    <p>{{ desc }}</p>
    <p>
      <em @click="showUsers = !showUsers">Users</em>
      <ul v-if="showUsers">
        <li v-for="user in users" :key="user.id">
          <UserInfo
            v-bind="user"
          ></UserInfo>
        </li>
      </ul>
    </p>
  </div>
</template>

<script>
import UserInfo from '../user/UserInfo.vue'

export default {
  props: {
    id: Number,
    name: String,
    desc: String,
    create_time: String,
    size: Number,
    users: Array,
    joincode: String,
  },
  components: {
    UserInfo,
  },
  data() {
    return {
      showUsers: false,
    }
  },
}
</script>
