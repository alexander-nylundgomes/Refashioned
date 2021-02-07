<template>
  <v-container class="loading" v-if="loading">
    <v-progress-circular
      indeterminate
      color="grey lighten-5"
    ></v-progress-circular>
  </v-container>
</template>

<script>
export default {
  name: "Loading",
  props: ["loading"]
};
</script>

<style lang="scss" scoped>
.loading {
  width: 100vw;
  height: 100vh;
  position: fixed;
  top: 0;
  left: 0;
  background-color: rgba(0, 0, 0, 0.7);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 100;
}
</style>
