<template>
  <main class="admin-products">
    <v-select
      class="mr-2 ml-2 mt-5"
      @change="filter()"
      outlined
      dense
      label="Show..."
      :items="shows"
      item-value="id"
      v-model="show"
    ></v-select>
    <v-select
      class="mr-2 ml-2"
      @change="filter()"
      outlined
      dense
      label="Sort by..."
      :items="sorts"
      item-value="id"
      v-model="sortType"
    ></v-select>

    <AdminAddProduct
      :colors="colors"
      :qualities="qualities"
      :categories="categories"
      :brands="brands"
    />

    <v-divider class="mb-5 mr-2 ml-2 mt-5"></v-divider>

    <v-data-iterator
      :items="showProducts"
      item-key="id"
      :items-per-page="4"
    >
      <!-- <template v-slot:default="{ items, isExpanded, expand }"> -->
      <template v-slot:default="{ items }">
        <v-row class="max-width ma-0">
          <v-col cols="12" class="pt-0 pr-0 pl-0">
            <AdminProduct
              v-for="item of items"
              :key="item.id"
              :product="item"
              :qualities="qualities"
              :colors="colors"
              :categories="categories"
              :brands="brands"
            />
          </v-col>
        </v-row>
      </template>
    </v-data-iterator>
  </main>
</template>

<script>
import AdminProduct from "@/components/AdminProduct.vue";
import AdminAddProduct from "@/components/AdminAddProduct.vue";
// const axios = require("axios");

export default {
  name: "AdminProducts",
  data() {
    return {
      showProducts: null,

      shows: [
        { text: "Available", id: 1 },
        { text: "Not available", id: 2 },
        { text: "All", id: 3 }
      ],
      show: {},

      sorts: [
        { text: "New", id: 1 },
        { text: "Old", id: 2 },
        { text: "No sorting", id: 3 }
      ],
      sortType: {}
    };
  },

  methods: {
    filter() {
      switch (this.show) {
        case 1:
          this.showProducts = this.products.filter(p => p.bought == false);
          break;
        case 2:
          this.showProducts = this.products.filter(p => p.bought == true);
          break;
        case 3:
          this.showProducts = this.products;
          break;
      }

      switch (this.sortType) {
        case 1:
          this.showProducts.sort(function(a, b) {
            return b.id - a.id;
          });
          break;
        case 2:
          this.showProducts.sort(function(a, b) {
            return a.id - b.id;
          });
          break;
        case 3:
          this.showProducts;
          break;
      }
    }
  },

  created() {
    this.showProducts = this.products;
  },

  computed: {
    products(){
      return this.$store.getters.products;
    },

    qualities(){
      return this.$store.getters.qualities;
    },

    colors(){
      return this.$store.getters.colors;
    },

    brands(){
      return this.$store.getters.brands;
    },

    categories(){
      return this.$store.getters.categories;
    }
  },

  components: {
    AdminProduct,
    AdminAddProduct
  }
};
</script>

<style lang="scss">
.max-width {
  max-width: 100%;
}

main.admin-products {
  .v-data-footer {
    padding: 0 !important;
  }

  // .v-data-footer__icons-before, .v-data-footer__icons-after{
  //   *{
  //     font-size: 1em !important;
  //   }
  // }
}
</style>
