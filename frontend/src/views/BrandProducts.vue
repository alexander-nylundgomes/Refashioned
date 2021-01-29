<template>
  <main class="brand-products">
      <h2 class="pa-4">{{ brand.name }}</h2>
      <div class="products">
        <Product
            v-for="product of products"
            :key="product.id"
            :product="product"
        />
      </div>
  </main>
</template>

<script>

import Product from "@/components/Product.vue"
export default {
    name: "BrandProducts",
    props: ['id'],

    data(){
        return{
            products: [],
            brand: this.$store.getters.brands.find(x => x.id == this.id),
        }
    },

    methods: {
        getProducts(){
            console.log(this.$store.getters.products.filter(p => p.brand_id == this.id))
            this.products = this.$store.getters.products.filter(p => p.brand_id == this.id);
        }
    },

    created(){
        this.getProducts();
    },

    components: {
        Product
    },
}
</script>

<style lang="scss" scoped>
    main.brand-products{


        .products{
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 1em 0;
            >*{
                margin: 1em 0;
            }
        }
    }
</style>