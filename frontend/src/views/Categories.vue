<template>
  <main class="categories">
      <!-- <h1 v-for="category of categories" :key="category">{{ category.display_text }}</h1> -->
      <v-card class="ma-auto mt-5 cardCat" v-for="category of categories" :key="category.id">
          <v-card-title>{{ category.cat_name }}</v-card-title>
          <v-card-subtitle>{{ category.description }}</v-card-subtitle>
          <div class="img-replace"></div>
          <v-card-actions>
              <router-link class="link full-width" :to="'/category/' + category.id">
                <v-btn large depressed block color="primary" class="ma-0">See products</v-btn>
              </router-link>
          </v-card-actions>
      </v-card>

  </main>
</template>

<script>

export default {
    name: "Categories",


    computed: {
        categories(){
            console.log(this.$store.getters.categories)
            return this.$store.getters.categories;
        }
    }
}
</script>

<style lang="scss" scoped>
    main.categories{
        display: flex;
        flex-direction: column;
    }

    .cardCat{
        height: fit-content;
        width: 90%;
    }

    .img-replace{
        width: 90%;
        margin: 0 auto;
        background-color: lightgray;
        height: 15rem;
    }

    .full-width{
        width: 100%;
    }
</style>