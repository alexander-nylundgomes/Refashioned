<template>
  <main class="products">
      <ProductContainer 
        :products="this.$store.getters.products"
      />
  </main>
</template>

<script>
import ProductContainer from "@/components/ProductContainer.vue"

export default {
    name: "Products",
    components: {
        ProductContainer
    }
}
</script>

<style lang="scss" scoped>

</style>