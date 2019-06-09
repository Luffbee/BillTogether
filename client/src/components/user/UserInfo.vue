<template>
  <span @click="toggleDetail" class="user-info">
      {{ name }}
      <div class="popup" v-if="detail">
        <em>Id:</em> {{ id }}
        <em>Name:</em> {{ name }}<br>
        <em>Email:</em> {{ email }}
      </div>
  </span>
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

<style>
.user-info {
  position: relative;
  cursor: pointer;
}
.popup {
  position: absolute;
  z-index: 1;
  top: 125%;
  left: 0%;
  width: max-content;
  border: solid 1px;
  background: white;
}
</style>
