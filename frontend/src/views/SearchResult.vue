<template>
  <main class="searchresult">
    <div class="text pa-3">
      <h1 class="title">Showing results for {{ tag }}</h1>
      <p>{{ this.results.length }} results</p>
    </div>

    <section class="products">
      <Product
        v-for="product of results"
        :key="product.id"
        :product="product"
      />
    </section>
  </main>
</template>

<script>
const axios = require("axios");

import Product from "@/components/Product.vue";
export default {
  name: "SearchResult",
  props: ["tag"],

  data() {
    return {
      results: []
    };
  },

  components: {
    Product
  },

  methods: {
    async getResults() {
      let results = await axios
        .get(`${process.env.VUE_APP_BACKEND}/search/${this.tag}`)
        .then(function(resp) {
          console.log(resp);
          return resp.data;
        })
        .catch(function(error) {
          alert(error);
        });

      this.results = results;
    }
  },

  created() {
    this.getResults();
  }
};
</script>

<style lang="scss">
main.searchresult {
  // padding: 0.75em;

  section.products {
    width: 100%;
    height: fit-content;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;

    > * {
      margin: 1em 0;
    }
  }
}
</style>
