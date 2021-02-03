<template>
  <main class="type-products">
      <div class="main-text">
            <h2>{{ type.name }}</h2>
            <p>{{ type.description }}</p>
      </div>
      <div class="products-wrapper">
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
    props: ['itemTypeSing', 'itemTypePlur'],

    data(){
        return{
            id: this.$route.params.id,
            products: [],
            type: []
        }
    },

    methods: {
        getProducts(){
            let id = this.$route.params.id;
            this.products = this.$store.getters.products.filter(p => p[`${this.itemTypeSing}_id`] == id);
            this.type = this.$store.getters[this.itemTypePlur].find(x => x.id == id)
            console.log(this.type)
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
    main.type-products{
    display: flex;
    align-items: center;
    flex-direction: column;
    height: fit-content;

    }
</style>