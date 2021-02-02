<template>
  <section class="products">
    <!-- <v-row class="ma-3 d-flex" justify="center">
        <h3 class="ma-0">Showing pants</h3>
        <v-spacer></v-spacer>
        <p class="ma-0">10 of 112</p>
      </v-row> -->
    <Product v-for="item of products" :key="item.id" :product="item" />
    <v-card width="200" color="primary" class="last-card  ml-2 mr-2">
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
  props: ["products"],
  components: {
    Product
  }
};
</script>

<style lang="scss" scoped>
section.products {
  width: 95%;
  margin: 1em auto;
  // background-color: rgb(240,240,240);
  overflow-x: scroll;
  overflow-y: hidden;
  white-space: nowrap;
  padding: 0.5em;
  height: fit-content;
}

.last-card{
  overflow: hidden;
  display: inline-block;
  height: 100%;
  
  .to_all{
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 1.25em;
    font-weight: 700;
    color: whitesmoke;
    text-decoration: underline;
  }
}
</style>
