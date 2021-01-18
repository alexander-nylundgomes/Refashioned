<template>
  <section class="products">
      <Product 
      v-for="item of products" 
      :key="item.id"
      :name="item.name"
      :price="item.price"
      :size="item.size"
      :brand="'CK'"
      :text="item.desc"
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
        background-color: rgb(240,240,240);
        overflow-x: scroll;
        white-space: nowrap;
        padding: 1em;
        height: fit-content;
    }
</style>