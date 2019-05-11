<template>
  <div id="welcome">
    Welcome<br>
    <button @click="$emit('go-login')">Login</button>
    <button @click="$emit('go-register')">Register</button>
  </div>
</template>

<script>
export default {
}
</script>
