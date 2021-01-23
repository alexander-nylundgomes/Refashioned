<template>
  <main class="products">
    <v-img src="@/assets/product_frontpage.jpg">
      <div class="overlay">
        <h2>Who said fashion cannot be <i>sustainable?</i></h2>
        <p>
          At Refashioned, we provide you with only the top quality vintage,
          high-end and branded clothes. All while saving the earth.
        </p>
      </div>
    </v-img>
    <TitleCardProducts
      :name="'Groovy Shirts'"
      :amount="'12'"
      :all="'56'"
      :category="'shirts'"
      :buttons="true"
    />
    <ProductContainer :products="this.$store.getters.products" />
    <TitleCardProducts
      :name="'Groovy Pants'"
      :amount="'11'"
      :all="'26'"
      :category="'pants'"
      :buttons="true"
    />
    <ProductContainer :products="this.$store.getters.products" />
    <!-- <v-btn @click="clear()">clear local storage</v-btn> -->
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

main.products {
  section.products:nth-of-type(1) {
    margin-top: 0;
  }
}
</style>
