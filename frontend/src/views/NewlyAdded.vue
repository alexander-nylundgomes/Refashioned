<template>
  <main class="newly-added">
      <div class="text pa-3">
          <h2 class="pb-2">Products added this month</h2>
          <p>These products were just added to our store! Here, you'll find the items which no one else have found yet! So look here often for great deals, before anyone else can get their hands on them!</p>
      </div>
      <div class="products-wrapper">
        <Product v-for="product of products" :key="product.id" :product="product"/>
      </div>
  </main>
</template>

<script>
import Product from "@/components/Product.vue"
export default {
    name: "NewlyAdded",

    data(){
        return{
            products: []
        }
    },

    components: {
        Product
    },

    created(){
        this.getProducts();
    },

    methods: {
        getProducts(){
            // Gets products which were added this month
            let month = new Date().getMonth() + 1;
            month = month.toString();

            if(month.length == 1){
                month = "0" + month
            }

            this.products = this.$store.getters.products.filter(p => p.created_at.startsWith(`2021-${month}`))
        }
    }
}
</script>

<style lang="scss" scoped>

</style>