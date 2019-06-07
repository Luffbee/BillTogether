<template>
  <ul>
    <li v-for="group in groups" :key="group.id">
      <div @click="$emit('groupDetail', group.idx)">
        <GroupInfo
          :detail="false"
          v-bind="group"
        ></GroupInfo>
      </div>
    </li>
  </ul>
</template>

<script>
import GroupInfo from './GroupInfo.vue'

export default {
  props: {
    groups: Array,
  },
  components: {
    GroupInfo,
  },
}
</script>
