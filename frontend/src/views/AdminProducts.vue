<template>
  <main class="admin-products">
      <v-data-iterator
        :items="products"
        item-key="id"
        :items-per-page="4"
        v-if="loaded"
      >
    <!-- <template v-slot:default="{ items, isExpanded, expand }"> -->
    <template v-slot:default="{ items }">
        <v-row>
          <v-col
            v-for="item of items"
            :key="item.id"
            cols="12"
          >

            <AdminProduct :product="item" :qualities="qualities" :colors="colors"/>
          </v-col>
        </v-row>
      </template>
      </v-data-iterator>
  </main>
</template>

<script>
import AdminProduct from "@/components/AdminProduct.vue";
const axios = require('axios');

export default {
    name: "AdminProducts",
    data(){
        return{
            products: [],
            loaded: false,
            qualities: [],
            colors: [],
        }  
    },
    methods: {
        async getProducts(){
            let vue = this;

            axios.get(`${process.env.VUE_APP_BACKEND}/all_products`)
            .then(function(resp){
                console.log(resp.data)
                vue.products = resp.data;
                vue.loaded = true;
            })
            .catch(function(error){ alert(error); })
        }
    },
    created(){
        this.getProducts();
        this.qualities = this.$store.getters.qualities;
        this.colors = this.$store.getters.colors;
        console.log(this.qualities)
    },

    components: {
        AdminProduct
    }
}
</script>

<style lang="scss">

</style>