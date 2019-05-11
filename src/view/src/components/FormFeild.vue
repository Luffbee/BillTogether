<template>
  <label>
    {{ feild.name }}
    <input
      :type="feild.type"
      :placeholder="feild.placeholder"
      :id="feild.name.toLowerCase()"
      :name="feild.name.toLowerCase()"
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
