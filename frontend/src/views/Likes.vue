<template>
    <main class="likes">
        <Product 
            v-for="product of products"
            :key="product.id"
            :product="product"
        />

        <div class="zero-saves" v-if="products.length == 0">
            <h2>You have no likes!</h2>
            <p :class="{'changed-subtitle': $vuetify.breakpoint.xs}">You have not liked any products. You don't need an account and no data is being stored in our databases. Instead, all of your liked products will be saved to your device! Great huh?</p>
        </div>
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

        .zero-saves{
            display: flex;
            flex-direction: column;
            // justify-content: center;
            margin-top: 25%;
            align-items: center;

            > *{
                text-align: center;
            }
        }
    }
</style>