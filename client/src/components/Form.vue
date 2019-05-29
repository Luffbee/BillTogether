<template>
  <form :id="formId">
    <Feild
      v-for="feild in feilds"
      :key="feild.name"
      :feild="feild"
    />
  </form>
</template>

<script>
import Feild from './FormFeild.vue'

export default {
  props: {
    formId: {
      type: String,
      required: true,
    },
    feilds: {
      type: Array,
      required: true,
    },
  },
  components: {
    Feild,
  },
}
</script>
