<template>
  <section class="products">
    <Product v-for="item of products" :key="item.id" :product="item" />
    <v-card
      v-if="moreProducts == true || moreProducts == undefined"
      width="175"
      class="last-card  ml-2 mr-2"
      elevation="0"
    >
      <router-link class="to_all" :to="'/filter'">
        See more!
      </router-link>
    </v-card>
  </section>
</template>

<script>
import Product from "@/components/Product.vue";
export default {
  name: "ProductContainer",
  props: ["products", "moreProducts"],
  components: {
    Product
  }
};
</script>

<style lang="scss">
section.products {
  width: 95%;
  // Removed line below could break
  // margin: 1em auto;
  overflow-x: scroll;
  overflow-y: hidden;
  white-space: nowrap;
  padding: 0.5em;
  height: fit-content;
}

.last-card {
  overflow: hidden;
  display: inline-block;
  height: 100%;
  background: linear-gradient(45deg, rgba(190,190,190,0.25), rgba(230,230,230,0.4));

  .to_all {
  // filter: blur(2px);
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 1.25em;
    font-weight: 700;
    color: rgba(20,20,20,0.75);
    text-decoration: none;
  }
}
</style>
