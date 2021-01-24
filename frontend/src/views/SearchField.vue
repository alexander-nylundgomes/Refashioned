<template>
  <main class="searchfield">
      <v-container class="pt-10">
          <v-row>
              <v-col class="pa-5 pt-1">
                  <h1 class="search-title">Search</h1>
                  <p class="search-text">Search for products, brands, categories...you name it! But remember, all stock is limited to one single item. We might receive more of the clothes you like in the future, but we strongly recommend you buying the items you like once you seem them so you don't miss out!</p>
              </v-col>
          </v-row>

          <v-row>
              <v-col>
                <v-text-field
                    outlined
                    dense
                    hide-details
                    label="Search..."
                    v-model="search"
                ></v-text-field>
              </v-col>
          </v-row>

          <v-row>
              <v-col>
                    <v-btn block large depressed class="pa-3" color="primary" @click="runSearch()" dark>search</v-btn>
              </v-col>
          </v-row>
      </v-container>

  </main>
</template>

<script>
export default {
    name: "SearchField",
    data(){
        return{
            search: "",
        }
    },

    methods: {
        runSearch(){
            this.$router.push({ path: `/search/${this.search}` })
        }
    }
}
</script>

<style lang="scss" scoped>
    .search-text{
        font-size: 0.75rem;
    }

    .search-title{
        font-size: 2rem;
        width: 100%;
        height: fit-content;
    }

</style>