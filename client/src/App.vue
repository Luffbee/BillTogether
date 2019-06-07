<template>
  <div id="app">
    <div id="error" v-if="error">
      {{ error.message }}
    </div>
    <component
      :is="currentView"
      v-bind="props"
    ></component>
  </div>
</template>

<script>
import { store } from './components/common/Store.vue'

export default {
  name: 'app',
  data () {
    return {
      state: store.state,
      props: {},
    }
  },
  computed: {
    currentView() {
      return this.state.currentView
    },
    error() {
      return this.state.error
    },
  },
  methods: {
  },
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
