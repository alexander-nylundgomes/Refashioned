<template>
  <main class="likes">
    <Product v-for="product of products" :key="product.id" :product="product" />

    <div class="main-text" v-if="products.length == 0">
      <h2>You have no likes!</h2>
      <p>
        You have not liked any products. You don't need an account and no data
        is being stored in our databases. Instead, all of your liked products
        will be saved to your device! Great huh?
      </p>
    </div>
  </main>
</template>

<script>
import Product from "@/components/Product.vue";
export default {
  name: "Likes",
  components: {
    Product
  },
  computed: {
    products() {
      return this.$store.getters.likes;
    }
  }
};
</script>

<style lang="scss" scoped>
main.likes {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  padding: 1em;

  > * {
    margin: 1rem;
  }
}
</style>
