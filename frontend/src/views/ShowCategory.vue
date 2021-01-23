<template>
  <main class="show-category">
    <h2>{{ category.cat_name }}</h2>
    <div class="show-products">
      <Product
        v-for="product of products"
        :key="product.id"
        :product="product"
      />
    </div>
  </main>
</template>

<script>
import Product from "@/components/Product.vue";

export default {
  name: "ShowCategory",
  props: ["id"],

  data() {
    return {
      products: [],
      category: []
    };
  },

  components: {
    Product
  },

  methods: {
    getProducts() {
      let products = this.$store.getters.products;
      this.products = products.filter(p => p.category_id == this.id);
    },

    setName() {
      let categories = this.$store.getters.categories;
      this.category = categories.filter(c => c.id == this.id)[0];
      console.log(this.category);
    }
  },

  created() {
    this.getProducts();
    this.setName();
  }
};
</script>

<style lang="scss">
main.show-category {
  h2 {
    width: fit-content;
    height: fit-content;
    margin: 0.5em auto;
  }

  .show-products {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    align-items: center;

    > * {
      margin: 1rem;
    }
  }
}
</style>
