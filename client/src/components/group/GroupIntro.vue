<template>
  <div>
    <em>{{ name }}</em> ({{ size }})
    <span>GID: {{ id }}</span>
  </div>
</template>

<script>
export default {
  props: {
    id: Number,
    name: String,
    size: Number,
  },
}
</script>
