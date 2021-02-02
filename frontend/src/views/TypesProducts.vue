<template>
  <main class="type-products">
      <h2 class="pa-4">{{ type.name }}</h2>
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