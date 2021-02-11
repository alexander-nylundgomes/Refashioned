<template>
  <main class="categories">
    <section class="categories">
      <AdminCategory
        @update="update($event)"
        @destroy="destroy($event)"
        :category="category"
        v-for="category of categories"
        :key="category.id"
      />
    </section>
    <Snackbar
      :snackbar="snackbar"
      :snackbarText="snackbarText"
      @closeSnackbar="snackbar = false"
    />
  </main>
</template>

<script>
import AdminCategory from "@/components/AdminCategory.vue";
import Snackbar from "@/components/Snackbar.vue";
export default {
  name: "AdminCategories",

  data() {
    return {
      snackbar: false,
      snackbarText: ""
    };
  },

  methods: {
    update(e) {
      this.snackbarText = "Category was updated successfully!";
      this.snackbar = true;

      this.$store.commit("updateCategory", e);
    },

    destroy(e) {
      this.snackbarText = "Category was deleted successfully!";
      this.snackbar = true;

      this.$store.commit("deleteCategory", e);
    }
  },

  computed: {
    categories() {
      return this.$store.getters.categories;
    }
  },

  components: {
    AdminCategory,
    Snackbar
  }
};
</script>

<style lang="scss" scoped></style>
