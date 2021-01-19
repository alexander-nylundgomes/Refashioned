<template>
    <main class="likes">
        <Product 
            v-for="product of products"
            :key="product.id"
            :product="product"
        />
    </main>
</template>

<script>
import Product from "@/components/Product.vue";
export default {
    name: "Likes",
    components: {
        Product
    },
    computed: {
        products(){
            return this.$store.getters.likes;
        }
    }
}
</script>

<style lang="scss" scoped>
    main.likes{
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        padding: 1em;

        > *{
            margin: 1rem;
        }
    }
</style>