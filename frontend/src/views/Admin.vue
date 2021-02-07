<template>
  <main class="admin">
    <div class="main-text">
      <h2>Welcome!</h2>
      <v-btn @click="$router.push('/payment-success')">click</v-btn>
    </div>
  </main>
</template>

<script>
export default {
  name: "Admin",
  methods: {}
};
</script>

<style lang="scss" scoped></style>
