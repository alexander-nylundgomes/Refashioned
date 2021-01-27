<template>
  <main class="categories">
    <Group 
      v-for="category of categories"
      :key="category.id"
      :title="category.cat_name"
      :desc="category.description"
      :img_path="''"
      :link="'/category/' + category.id"
    />
  </main>
</template>

<script>

import Group from "@/components/Group.vue"

export default {
  name: "Categories",

  computed: {
    categories() {
      console.log(this.$store.getters.categories);
      return this.$store.getters.categories;
    }
  },

  components: {
    Group
  }
};
</script>

<style lang="scss" scoped>
main.categories {
  display: flex;
  flex-direction: column;
}

.cardCat {
  height: fit-content;
  width: 90%;
}
</style>
