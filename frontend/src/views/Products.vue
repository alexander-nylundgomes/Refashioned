<template>
  <main class="products">
      <ProductContainer 
        :products="this.$store.getters.products"
      />
      <v-btn @click="clear()">clear local storage</v-btn>
  </main>
</template>

<script>
import ProductContainer from "@/components/ProductContainer.vue"

export default {
    name: "Products",
    components: {
        ProductContainer
    },
    methods: {
        clear(){
            localStorage.removeItem('likes')
        }
    }
}
</script>

<style lang="scss" scoped>

</style>