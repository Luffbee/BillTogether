<template>
  <label>
    {{ feild.name }}
    <input
      :type="feild.type"
      :placeholder="feild.placeholder"
      :id="feild.name.toLowerCase().split(' ').join('-')"
      :name="feild.name.toLowerCase().split(' ').join('-')"
      :value="feild.value"
    ><br>
  </label>
</template>

<script>
export default {
  props: {
    feild: {
      type: Object,
      required: true,
    },
  },
}
</script>
