<template>
  <main class="saved_categories pa-4">
    <h2>Your saved categories</h2>
  </main>
</template>

<script>
export default {
  name: "SavedCategories",
  data() {
    return {
      categories: []
    };
  },

  methods: {
    placeCategories() {
      this.categories = this.$store.getters.liked_categories;
      console.log(this.categories);
    }
  },

  created() {
    this.placeCategories();
  }
};
</script>

<style lang="scss" scoped>
main.saved_categories {
}
</style>
