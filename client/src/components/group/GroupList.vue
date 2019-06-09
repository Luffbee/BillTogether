<template>
  <ul>
    <li v-for="group in groups" :key="group.id">
      <div @click="$emit('groupDetail', group.idx)">
        <GroupIntro
          v-bind="group"
        ></GroupIntro>
      </div>
    </li>
  </ul>
</template>

<script>
import GroupIntro from './GroupIntro.vue'

export default {
  props: {
    groups: Array,
  },
  components: {
    GroupIntro,
  },
}
</script>
