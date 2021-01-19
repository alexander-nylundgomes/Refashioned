<template>
  <section class="products">
      <!-- <v-row class="ma-3 d-flex" justify="center">
        <h3 class="ma-0">Showing pants</h3>
        <v-spacer></v-spacer>
        <p class="ma-0">10 of 112</p>
      </v-row> -->
      <Product 
      v-for="item of products" 
      :key="item.id"
      :product="item"
      />
  </section>
</template>

<script>
import Product from "@/components/Product.vue";
export default {
    name: "ProductContainer",
    props: ['products'],
    components: {
        Product
    }
}
</script>

<style lang="scss">
    section.products{
        width: 95%;
        margin: 1em auto;
        // background-color: rgb(240,240,240);
        overflow-x: scroll;
        white-space: nowrap;
        padding: 0.5em;
        height: fit-content;
    }
</style>