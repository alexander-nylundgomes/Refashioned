<template>
  <main class="products">
    <v-img class="front-image" src="@/assets/product_frontpage.jpg">
      <div class="overlay">
        <h2>Who said fashion cannot be <i>sustainable?</i></h2>
        <p>
          At Refashioned, we provide you with only the top quality vintage,
          high-end and branded clothes. All while saving the earth.
        </p>
      </div>
    </v-img>

    <TitleCardProducts
      :name="'Popular brands'"
      :category="3"
      :amount="products.slice(0, 10).length"
      :all="products.length"
    />
    <ProductContainer :products="products.slice(0, 10)" />
  </main>
</template>

<script>
import ProductContainer from "@/components/ProductContainer.vue";
import TitleCardProducts from "@/components/TitleCardProducts.vue";

export default {
  name: "Products",
  components: {
    ProductContainer,
    TitleCardProducts
  },

  data() {
    return {
      products: this.$store.getters.products
    };
  },

  methods: {
    clear() {
      localStorage.removeItem("likes");
    }
  }
};
</script>

<style lang="scss" scoped>
.front-image {
  width: calc(100% - 1em);
  margin: 0.5em;
  margin-bottom: 0;

  .overlay {
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.45);
    h2 {
      color: white;
      font-size: 2.5rem;
      padding: 0.5em 0 0 0.5em;
      font-weight: 800;
      line-height: 1.2;
    }

    p {
      color: white;
      padding: 0 0.5em 0 1.5em;
      font-size: 0.9rem;
      font-weight: 500;
      width: 75%;
    }
  }
}

main.products {
  display: flex;
  align-items: center;
  flex-direction: column;
  height: fit-content;
}
</style>
