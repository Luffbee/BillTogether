<template>
  <div @click="toggleDetail">
    <p><em>Name:</em> {{ name }}</p>
    <template v-if="detail">
      <p><em>Id:</em> {{ id }}</p>
      <p><em>Email:</em> {{ email }}</p>
    </template>
  </div>
</template>

<script>
export default {
  props: {
    id: Number,
    name: String,
    email: String,
  },
  data() {
    return {
      detail: false,
    }
  },
  methods: {
    toggleDetail() {
      this.detail = !this.detail
    }
  }
}
</script>
